FROM nginx:alpine

# Copy the HTML file to nginx web root as index.html
COPY src/traccar.html /usr/share/nginx/html/index.html

COPY docker-entrypoint.sh /docker-entrypoint.sh

# Make the script executable
RUN chmod +x /docker-entrypoint.sh

# Expose port 80
EXPOSE 80

# Define the entrypoint
ENTRYPOINT ["/docker-entrypoint.sh"]

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
