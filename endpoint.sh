#!/bin/sh
# Generate a minimal torrc at container start so we can pick up $PORT
cat <<EOF >/etc/tor/torrc
# Don’t fork; keep in foreground so Docker can manage it
RunAsDaemon 0

# Where Tor stores its state
DataDirectory /var/lib/tor

# Listen on all interfaces at the port Render provides (default 9050)
SocksPort 0.0.0.0:${PORT:-9050}

# Log notices to stdout for debugging
Log notice stdout
EOF

# Execute Tor with our generated config
exec tor -f /etc/tor/torrc
