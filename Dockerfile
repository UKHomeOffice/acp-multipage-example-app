FROM nginx:1.19.2-alpine
RUN addgroup -S app \
        && adduser -S -g app -u 1000 app
COPY ./default.conf /etc/nginx/conf.d
COPY ./webpages/ /usr/share/nginx/html
RUN chown -R 1000:1000 /usr/share/nginx && \
        chown -R 1000:1000 /var/cache/nginx && \
        chown -R 1000:1000 /var/log/nginx && \
        chown -R 1000:1000 /etc/nginx/conf.d
RUN touch /var/run/nginx.pid && \
        chown -R 1000:1000 /var/run/nginx.pid
USER 1000
EXPOSE 3000
