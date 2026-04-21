#!/bin/bash

# Check the app container
/usr/bin/docker top "vaultwarden" >/dev/null 2>&1
RC_APP=$?

# Check the fail2ban container
/usr/bin/docker top "fail2ban" >/dev/null 2>&1
RC_F2B=$?

# Use the correct variable names for the sum
SUM_RC=$((RC_APP + RC_F2B))

echo "Combined Exit Status: $SUM_RC"

# Exit with the sum (0 if both are running, >0 if any failed)
exit $SUM_RC
