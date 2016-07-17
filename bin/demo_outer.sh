#!/bin/bash

declare -x exported_var="outer value"

echo "outer before: $exported_var"

./bin/demo_inner.sh

echo "outer after: $exported_var"
