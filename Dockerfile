# Use official Nginx image as base
FROM nginx:alpine

# Copy our HTML file to Nginx web directory
COPY index.html /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# Nginx starts automatically with the base image
