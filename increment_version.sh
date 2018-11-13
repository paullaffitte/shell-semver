#!/usr/bin/env bash

# Increment a version string using Semantic Versioning (SemVer) terminology.
function semverIncr
{
  local OPTIND Option major minor patch tag version
  while getopts ":Mmpt:" Option; do
    case "$Option" in
      M ) major=true;;
      m ) minor=true;;
      p ) patch=true;;
      t ) tag="-${OPTARG}";;
    esac
  done
  shift $(($OPTIND - 1))

  version=$(expr "$1" : '\(.*\)\-.*' || echo "$1")
  if [ -z "$tag" ]; then
    tag=$(expr "$1" : '.*\(\-.*\)')
  elif [ "$tag" == "-" ]; then
    tag=''
  fi

  # Build array from version string.
  a=( ${version//./ } )

  # If version string is missing or has the wrong number of members, show usage message.
  if [ ${#a[@]} -ne 3 ]; then
    echo "usage: $(basename $0) [-Mmpt:]"
    exit 1
  fi

  # Increment version numbers as requested.
  if [ ! -z $major ]; then
    ((a[0]++))
    a[1]=0
    a[2]=0
  fi

  if [ ! -z $minor ]; then
    ((a[1]++))
    a[2]=0
  fi

  if [ ! -z $patch ]; then
    ((a[2]++))
  fi

  echo "${a[0]}.${a[1]}.${a[2]}$tag"
}

if ! [ -f .semver ]; then
  VERSION='0.0.1-beta'
  echo "$VERSION" > .semver
else
  VERSION=$(cat .semver)
fi

NEW_VERSION=$(semverIncr "$@" $VERSION)
echo $NEW_VERSION
echo $NEW_VERSION > .semver
