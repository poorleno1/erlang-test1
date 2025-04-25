FROM erlang:25-alpine AS builder
WORKDIR /app
COPY rebar.config .
RUN rebar3 get-deps
COPY . .
RUN rebar3 as prod release

FROM alpine:3.18
RUN apk add net-tools --no-cache ncurses-libs openssl libstdc++ libgcc
COPY --from=builder /app/_build/prod/rel/hello_docker /app
# Correct ERTS and boot file paths
COPY --from=builder /usr/local/lib/erlang/erts-13.2.2.15 /app/erts-13.2.2.15
ENV PATH="/app/erts-13.2.2.15/bin:/app/bin:$PATH"
EXPOSE 8080
CMD ["/app/bin/hello_docker", "foreground"]
