#!/usr/bin/env bash
HAS_FAILURE=0

COMMAND="speccy lint"
# We don't have tags in every OAS
COMMAND="$COMMAND -s openapi-tags"
# Some operations don't need to be grouped
COMMAND="$COMMAND -s operation-tags"
# Sometimes we set default and example to the same value. We should fix this in the future
COMMAND="$COMMAND -s default-and-example-are-redundant"
# Our tag order is respected when rendering in the sidebar. We don't want them alphabetical
COMMAND="$COMMAND -s openapi-tags-alphabetical"

for i in $(ls definitions/*.yml); do
  echo -n "$i "

  OUTPUT=$($COMMAND $i 2>&1)
  if [[ $? == 0 ]]; then
    echo '✅'
  else
    HAS_FAILURE=1
    echo '❌'
    echo "########################"
    echo "$OUTPUT"
    echo "########################"
  fi
done

exit $HAS_FAILURE
