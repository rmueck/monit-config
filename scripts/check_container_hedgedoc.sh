#!/bin/bash

# Check the app container
/usr/bin/docker top "hedgedoc" >/dev/null 2>&1
RC_HD=$?

# Check the db container
/usr/bin/docker top "hedgedoc-db" >/dev/null 2>&1
RC_DB=$?

# Use the correct variable names for the sum
SUM_RC=$((RC_HD + RC_DB))

echo "Combined Exit Status: $SUM_RC"

# Exit with the sum (0 if both are running, >0 if any failed)
exit $SUM_RC
