#!/bin/bash
#SYNOPSIS
#This shell script checks for the last tag version and increments version according to the Semver format.
#Major minor and Patch version are maintained according to the argument Provided while calling the script.  
#Author : Baker communications, Inc.
#Website : www.bakercommunications.com


# create new tag
NEW_TAG='git rev-parse HEAD.trim()'
echo "($VERSION) updating $CURRENT_VERSION to $NEW_TAG"

# get current hash and see if it already has a tag
GIT_COMMIT=`git rev-parse HEAD`
NEEDS_TAG=`git describe --contains $GIT_COMMIT 2>/dev/null`

# only tag if no tag already
if [ -z "$NEEDS_TAG" ]; then
  echo "Tagged with $NEW_TAG"
  git tag $NEW_TAG
  git push --tags
  git push
else
  echo "Already a tag on this commit"
fi

echo ::set-output name=git-tag::$NEW_TAG

exit 0
