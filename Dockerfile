FROM golang:1.12.9-alpine
WORKDIR /mm_wiki
ENV MM_HOME /mm_wiki
ADD https://github.com/phachon/mm-wiki/releases/download/v0.1.3/mm-wiki-linux-amd64.tar.gz /tmp/mm-wiki-linux-amd64.tar.gz
RUN apk add --no-cache bash && \
    tar xvzf /tmp/mm-wiki-linux-amd64.tar.gz -C /mm_wiki

COPY start.sh ${MM_HOME}/start.sh
EXPOSE 8090

ENTRYPOINT ["/mm_wiki/start.sh"]