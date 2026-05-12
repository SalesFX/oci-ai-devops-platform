# Build stage
FROM node:20-alpine AS builder
WORKDIR /build
COPY index.html .
ARG ENV=dev
ARG VERSION=local
RUN sed -i "s/{{ENV}}/${ENV}/g; s/{{VERSION}}/${VERSION}/g" index.html

# Final stage
FROM nginx:1.27-alpine
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/app.conf
COPY --from=builder /build/index.html /usr/share/nginx/html/index.html

# Run as non-root
RUN chown -R nginx:nginx /usr/share/nginx/html && \
    chown -R nginx:nginx /var/cache/nginx && \
    touch /var/run/nginx.pid && \
    chown nginx:nginx /var/run/nginx.pid

USER nginx
EXPOSE 8080
HEALTHCHECK --interval=10s --timeout=3s --retries=3 \
  CMD wget -qO- http://localhost:8080/healthz || exit 1
