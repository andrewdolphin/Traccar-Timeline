#!/bin/sh

# Generate a JavaScript file injecting environment variables into the global window object.
# The `:-` ensures that if a variable is not set in docker-compose, it defaults to an empty string.
cat <<EOF > /usr/share/nginx/html/env-config.js
window.envConfig = {
  TRACCAR_API_URL: "${TRACCAR_API_URL:-}",
  TRACCAR_USERNAME: "${TRACCAR_USERNAME:-}",
  TRACCAR_PASSWORD: "${TRACCAR_PASSWORD:-}"
};
EOF

# Pass execution to the main container command (starting Nginx)
exec "$@"
