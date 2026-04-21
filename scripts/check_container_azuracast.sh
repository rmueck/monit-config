#!/bin/bash

# Check the app container
/usr/bin/docker top "azuracast" >/dev/null 2>&1
RC_APP=$?

# Check the db container
/usr/bin/docker top "azuracast_updater" >/dev/null 2>&1
RC_UP=$?

# Use the correct variable names for the sum
SUM_RC=$((RC_APP + RC_UP))

echo "Combined Exit Status: $SUM_RC"

# Exit with the sum (0 if both are running, >0 if any failed)
exit $SUM_RC
