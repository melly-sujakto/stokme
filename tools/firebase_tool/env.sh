#!/usr/bin/env bash

# How to run?
# => ./env.sh env=dev

if [ $# -eq 0 ]; then
    echo "[Error] please run command includes: $0 env=..."
    exit 1
fi

# Extract the value of 'env' from the argument
ENV_PARAM=$(echo "$1" | cut -d'=' -f2)

echo "⠇ Entering app project..."
cd ../../app/app_stokme
echo "⠇ Executing app env.sh..."
(source ./tools/env.sh env=$ENV_PARAM)

echo "⠇ Entering firebase tool project..."
cd ../../tools/firebase_tool
echo {$(grep -m 2 -e 'apiKey' -e 'projectId' ../../app/app_stokme/lib/firebase_options.dart)} > config.txt
dart run env.dart
rm config.txt
exit 0
