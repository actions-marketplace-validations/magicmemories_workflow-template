FROM ubuntu
COPY action.sh /usr/local/bin/deploy
RUN apt -y update && apt -y install curl \
    && pip install awscli
CMD deploy