FROM vault AS builder
WORKDIR /data/
ENV KUBEVERSION=v1.20.13
RUN apk add jq rclone curl gcc musl-dev python3-dev libffi-dev openssl-dev cargo make py3-pip ca-certificates
RUN python3 -m venv /data/azure-cli
RUN source /data/azure-cli/bin/activate && pip install azure-cli
RUN tar -zcvf  /azure-cli.tar.gz /data

FROM vault
RUN apk add jq rclone curl python3 ca-certificates
COPY --from=builder /azure-cli.tar.gz /data/azure-cli.tar.gz
RUN tar -zxvf /data/azure-cli.tar.gz && rm -rf /data/azure-cli.tar.gz
RUN curl -L "https://dl.k8s.io/release/${KUBEVERSION}/bin/linux/amd64/kubectl" -o /usr/bin/kubectl
RUN chmod +x /usr/bin/kubectl
