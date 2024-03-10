#!/usr/bin/env bash

# How to run?
# => ./env.sh env=dev

if [ $# -eq 0 ]; then
    echo "[Error] please run command includes: $0 env=..."
    exit 1
fi

# Extract the value of 'env' from the argument
ENV_PARAM=$(echo "$1" | cut -d'=' -f2)

if [ "$ENV_PARAM" == "prod" ]; then
    ENV="stokme"
elif [ "$ENV_PARAM" == "staging" ]; then
    ENV="stokme-staging"
else
    ENV="stokme-dev"
fi

echo "⠇ Preparing env..."
dart pub global activate flutterfire_cli > /dev/null 2>&1
export PATH="$PATH":"$HOME/.pub-cache/bin"
flutterfire configure --project=$ENV --platforms=android,ios -y
exit 0
