FROM python:3.8-slim-buster AS eks-help-deploy-action

COPY eks-help-deploy-action.sh /usr/local/bin/eks-help-deploy-action

# Install the toolset.
RUN apt -y update && apt -y install curl \
    && pip install awscli \
    && curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash \
    && curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.19.0/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl && mv ./kubectl /usr/local/bin/kubectl

CMD eks-help-deploy-action


FROM mozilla/sops:v3.6.1 AS sops-decrypt

COPY sops-decrypt.sh /sops-decrypt.sh

ENTRYPOINT ["bash","/sops-decrypt.sh"]