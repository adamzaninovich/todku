#!/usr/bin/env bash

echo "getting db ready..."
/app/bin/migrate

echo "starting web app"
/app/bin/server
