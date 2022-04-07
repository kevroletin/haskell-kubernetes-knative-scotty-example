FROM haskell:8.2.2 as builder

WORKDIR /app

COPY stack.yaml .
COPY package.yaml .
RUN stack setup
RUN stack install --only-dependencies

# ----

COPY . .
RUN stack build --copy-bins

FROM ubuntu

WORKDIR /root/
COPY --from=builder /root/.local/bin/kubernetes-hs-exe .

ENV PORT 8080

CMD ["./kubernetes-hs-exe"]