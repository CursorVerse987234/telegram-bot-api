FROM alpine:latest

# نصب ابزارهای مورد نیاز
RUN apk add --no-cache g++ make cmake git zlib-dev openssl-dev libstdc++

# دانلود سورس و build با submodules کامل
RUN git clone --recursive https://github.com/tdlib/telegram-bot-api.git \
    && cd telegram-bot-api \
    && mkdir build && cd build \
    && cmake -DCMAKE_BUILD_TYPE=Release .. \
    && cmake --build . --target telegram-bot-api

WORKDIR /telegram-bot-api/build
EXPOSE 8081

CMD ./telegram-bot-api --api-id=${API_ID} --api-hash=${API_HASH} --http-port=${PORT:-8081} --local --verbosity=2
