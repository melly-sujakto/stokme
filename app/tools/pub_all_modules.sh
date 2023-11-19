#!/bin/bash

function help() {
  echo "
        This command has to be run from the root dir of the project.

        Options:
        -c: run 'flutter clean'
        -g: run 'flutter pub get'
        -b: run 'build_runner build'
        -d: add '--delete-conflicting-outputs' to 'build_runner build' command
        -a: run 'flutter analyze'
        -t: run 'flutter test'
        -u: run 'flutter pub upgrade --major-versions'
        -f: run 'dart fix --apply'
        "
  exit 0
}

while getopts 'gbcdatuhf' OPTION; do
  case "${OPTION}" in
  g)
    pubGet=true
    ;;
  b)
    build=true
    ;;
  c)
    clean=true
    ;;
  d)
    deleteConflicts="--delete-conflicting-outputs"
    ;;
  a)
    analyze=true
    ;;
  t)
    test=true
    ;;
  u)
    pubUpgrade=true
    pubGet=true
    ;;
  f)
    fix=true
    ;;
  h)
    help
    ;;
  *)
    help
    ;;
  esac
done

if [ "${clean}" = true ]; then
  cmd="flutter clean;"
fi

if [ "${pubGet}" = true ]; then
  cmd="$cmd flutter pub get;"
fi

if [ "${build}" = true ]; then
  cmd="${cmd} flutter pub run build_runner build $deleteConflicts;"
fi

if [ "${analyze}" = true ]; then
  cmd="${cmd} flutter analyze;"
fi

if [ "${fix}" = true ]; then
  cmd="${cmd} dart fix --apply;"
fi

if [ "${test}" = true ]; then
  cmd="${cmd} flutter test test/;"
fi

if [ "${pubUpgrade}" = true ]; then
  cmd="flutter pub upgrade --major-versions; ${cmd}"
fi

echo "Running for each module:"
echo "$cmd"

function runCmd() {
  args=$1
  if [[ "${args}" == *"build_runner"* ]]; then
    echo "Arg requires build_runner"
    buildRunner=$(flutter pub deps -s compact | grep "\- build_runner ")
    if [ -z "$buildRunner" ]; then
      echo "build_runner not available"
      regex='([ ]{0,}flutter pub run build_runner build( --delete-conflicting-outputs)?[ ]{0,};)'
      while [[ $args =~ $regex ]]; do
        args=${args/"${BASH_REMATCH[1]}"/}
      done
    fi
  fi
  echo "Running ${args} on $(pwd)"
  sh -c "${args}"
}

export cmd
export -f runCmd

find ./** -name "pubspec.yaml" -execdir bash -c 'runCmd "$cmd" "{}"' \;
