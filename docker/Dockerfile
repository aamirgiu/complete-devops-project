# Complete DevOps Project - Application Image
# Author: Muhammad Aamir Sajjad
# Date: September 2026

FROM nginx:1.25-alpine

# Metadata
LABEL maintainer="Muhammad Aamir Sajjad"
LABEL version="1.0"
LABEL description="Complete DevOps Project Portfolio"

# Remove default nginx config
RUN rm -rf /etc/nginx/conf.d/default.conf

# Copy custom nginx config
COPY ../app/nginx.conf /etc/nginx/conf.d/default.conf

# Copy HTML files
COPY html/ /usr/share/nginx/html/

# Create non-root user
RUN addgroup -S nginxgroup && adduser -S nginxuser -G nginxgroup && \
    chown -R nginxuser:nginxgroup /usr/share/nginx/html && \
    chown -R nginxuser:nginxgroup /var/cache/nginx && \
    chown -R nginxuser:nginxgroup /var/log/nginx && \
    touch /var/run/nginx.pid && \
    chown -R nginxuser:nginxgroup /var/run/nginx.pid

USER nginxuser

# Expose port
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost:8080/health || exit 1

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
