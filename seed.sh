#!/usr/bin/sh

tr -dc _A-Za-z0-9 </dev/urandom | head -c7
echo ""
