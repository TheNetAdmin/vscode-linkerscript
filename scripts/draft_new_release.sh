#!/bin/bash

read -p "Input the new release version (without the leading 'v'): " version

jq ".version = \"$version\"" package.json > package.json.out && mv package.json.out package.json
git add package.json

msg="Bump to $version"
git commit -m "$msg"
git tag -a "v$version" -m "$msg"
