#!/bin/sh
set -e

# 1️⃣ Write a minimal torrc at container start
cat <<EOF >/etc/tor/torrc
# Don’t fork; let Docker manage the process
RunAsDaemon 0

# Persistent state
DataDirectory /var/lib/tor

# Listen on whatever PORT Render injects (default 9050)
SocksPort 0.0.0.0:${PORT:-9050}

# Log to stdout
Log notice stdout
EOF

# 2️⃣ Ensure permissions match the user Tor will run as
chown -R debian-tor:debian-tor /var/lib/tor /etc/tor/torrc

# 3️⃣ Exec Tor under debian-tor
exec start-stop-daemon \
     --start --quiet \
     --chuid debian-tor:debian-tor \
     --exec /usr/bin/tor -- -f /etc/tor/torrc
