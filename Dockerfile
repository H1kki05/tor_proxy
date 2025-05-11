# Use a slim Debian image
FROM debian:stable-slim

# Install Tor and clean up
RUN apt-get update \
 && apt-get install -y tor \
 && rm -rf /var/lib/apt/lists/*

# Ensure the Tor data directory exists and has proper ownership
RUN mkdir -p /var/lib/tor \
 && chown -R debian-tor:debian-tor /var/lib/tor

# Copy in our entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Expose the default SOCKS port
EXPOSE 9050

# Launch the entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
