#!/bin/bash

# Check the app container
/usr/bin/docker top "seafile" >/dev/null 2>&1
RC_APP=$?

# Check the db container
/usr/bin/docker top "seafile-mysql" >/dev/null 2>&1
RC_DB=$?

# Check the redis container
/usr/bin/docker top "seafile-redis" >/dev/null 2>&1
RC_RED=$?

# Use the correct variable names for the sum
SUM_RC=$((RC_APP + RC_DB + RC_RED))


echo "Combined Exit Status: $SUM_RC"

# Exit with the sum (0 if all are running, >0 if any failed)
exit $SUM_RC
