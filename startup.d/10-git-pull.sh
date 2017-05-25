#!/bin/sh

# Prepare code auditing environment
REPO_URL=$(git remote get-url origin)
TEST_DIR=$(mktemp -d)
git clone "$REPO_URL" "$TEST_DIR";
pushd "$TEST_DIR";

# Code auditing section
python -m py_compile $(find . -name '*.py');
if [ "$?" != "0" ]
then
  echo "There is syntax error. This may endanger chaos. Pauses updates."
  rm -r "$TEST_DIR";
  exit 45
fi

# End code auditing section
popd
rm -r "$TEST_DIR";

git checkout master
git pull
