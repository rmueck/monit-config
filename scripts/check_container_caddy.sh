#!/bin/bash

# Check the app container
/usr/bin/docker top "caddy" >/dev/null 2>&1
RC_APP=$?


# Use the correct variable names for the sum
SUM_RC=$((RC_APP))


echo "Combined Exit Status: $SUM_RC"

# Exit with the sum (0 if all are running, >0 if any failed)
exit $SUM_RC
