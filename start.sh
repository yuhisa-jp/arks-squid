#!/bin/bash

htpasswd -bcp /etc/squid/passwd "$SQUID_USERNAME" "$SQUID_PASSWORD"
squid -u 8080
