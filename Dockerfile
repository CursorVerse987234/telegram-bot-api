FROM alpine:latest

RUN apk add --no-cache g++ make cmake git zlib-dev openssl-dev libstdc++

RUN git clone https://github.com/tdlib/telegram-bot-api.git \
    && cd telegram-bot-api \
    && mkdir build && cd build \
    && cmake -DCMAKE_BUILD_TYPE=Release .. \
    && cmake --build . --target telegram-bot-api

WORKDIR /telegram-bot-api/build
EXPOSE 8081

CMD ./telegram-bot-api --api-id=27003408 --api-hash=85c06999c7c967fefe03f721e61f0e07 --http-port=${PORT:-8081} --local --verbosity=2
