FROM vault
ENV KUBEVERSION=v1.20.13
RUN apk add jq rclone curl gcc musl-dev python3-dev libffi-dev openssl-dev cargo make py3-pip
RUN pip install azure-cli
RUN curl -L "https://dl.k8s.io/release/${KUBEVERSION}/bin/linux/amd64/kubectl" -o /usr/bin/kubectl
RUN chmod +x /usr/bin/kubectl