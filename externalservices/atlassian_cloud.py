#!/usr/bin/env python
#
#### External Services Monitoring Scripts
#
#
# Author: Matthew Macdonald-Wallace
# (c) DevOpsGuys Ltd 2016
# Licensed under the MIT Software License
import sys
import json
import requests

status_url = "https://x67gp49yvrzv.statuspage.io/api/v2/summary.json"
status_data = requests.get(status_url)
status_json = json.loads(status_data.text)

if status_json['status']['indicator'] == 'none':
   exit_code = 0
   message = "Atlassian Cloud is online"
else:
   exit_code = 2
   message = "Atlassian Cloud is experiencing difficulties"

print message
sys.exit(exit_code)
