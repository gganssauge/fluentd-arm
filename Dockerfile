# WARNING: Cross-build doesn't work
FROM hypriot/rpi-alpine-scratch

ENV FLUENTD_VERSION=0.14.15

RUN apk --update add \
	ca-certificates \
	ruby \
	ruby-irb \
	&& apk add --virtual dev-dependencies \
	build-base \
	ruby-dev \
	&& gem update --system --no-document \
	&& gem install --no-document json \
	&& gem install --no-document json_pure jemalloc \
	&& gem install --no-document fluentd -v ${FLUENTD_VERSION} \
	&& gem install --no-document fluent-plugin-elasticsearch \
	&& gem install --no-document fluent-plugin-kubernetes_metadata_filter \
	&& gem install --no-document out_gelf \
	&& apk del dev-dependencies \
	&& rm -rf /tmp/* /var/tmp/* /var/cache/apk/*

COPY fluent.conf /etc/fluent/fluent.conf

CMD ["fluentd"]