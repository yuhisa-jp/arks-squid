#!/bin/bash

htpasswd -bcp /etc/squid/passwd "$SQUID_USERNAME" "$SQUID_PASSWORD"
squid -z
squid -N -u 8080
