#!/bin/bash

# remove remote tags
git ls-remote --tags origin | grep -ioP "refs/tags/\Kv[0-9]+\.[0-9]+\.[0-9]+$" | xargs -I {} git push origin :{}

# remove local tags
comm -23 <(git tag | sort) <(git ls-remote --tags origin | grep -ioP "refs/tags/\K.*" | sort) | xargs -r git tag -d

echo "Tags has been removed"
exit 0
