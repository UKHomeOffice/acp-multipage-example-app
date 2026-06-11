FROM nginx:1.30.2-alpine

RUN apk upgrade --no-cache

RUN addgroup -S app && \
        adduser -S -g app -u 1000 app

COPY --chown=1000:1000 ./default.conf /etc/nginx/conf.d

COPY --chown=1000:1000 ./webpages/ /usr/share/nginx/html

RUN chown -R 1000:1000 /usr/share/nginx /var/cache/nginx /var/log/nginx 

RUN touch /var/run/nginx.pid && \
        chown -R 1000:1000 /var/run/nginx.pid

USER 1000

EXPOSE 3000