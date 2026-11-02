#!/usr/bin/env python3
"""Bounded, credential-free diagnosis; never unsets proxy or changes policy."""
import json
from pathlib import Path
import socket
import urllib.request

ROOT = Path(__file__).resolve().parents[1]
record = {'status': 'UNKNOWN', 'checks': [], 'note': 'GitHub connector access is separate from network access of this process.'}
policy_file = Path('/etc/codex/network-policy.json')
if policy_file.is_file():
    policy = json.loads(policy_file.read_text())
    record['policy_version'] = policy.get('version')
    record['vpn_configured'] = policy.get('vpn_configured', False)
    record['proxy_configured'] = bool(policy.get('http_proxy'))
    hosts = {entry.get('host') for entry in policy.get('http_network_policy', {}).get('egress_rules', [])}
    record['configured_download_hosts'] = {host: host in hosts for host in ['github.com', 'release-assets.githubusercontent.com', 'dl.google.com']}
try:
    connection = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    connection.close()
    record['checks'].append({'stage': 'AF_INET_socket_creation', 'status': 'PASS'})
except OSError as error:
    record['checks'].append({'stage': 'AF_INET_socket_creation', 'status': 'BLOCKED', 'error': type(error).__name__, 'errno': error.errno, 'message': str(error)})
    record['status'] = 'BLOCKED_BEFORE_PROXY_DNS_TLS'
if record['status'] == 'UNKNOWN':
    for url in ['https://github.com/godotengine/godot-builds/releases/tag/4.6.3-stable', 'https://dl.google.com/android/repository/repository2-1.xml']:
        try:
            request = urllib.request.Request(url, method='HEAD')
            with urllib.request.urlopen(request, timeout=10) as response:
                record['checks'].append({'url': url, 'status': response.status})
        except OSError as error:
            record['checks'].append({'url': url, 'status': 'BLOCKED', 'message': str(error)})
    record['status'] = 'PASS' if all(c.get('status') in ['PASS', 200] for c in record['checks']) else 'BLOCKED_HTTPS'
output = ROOT / 'build/network_diagnosis.json'
output.parent.mkdir(exist_ok=True)
output.write_text(json.dumps(record, indent=2) + '\n')
print(json.dumps(record, indent=2))
