docker login docker.magicmemories.com --password=$DOCKERHUB_TOKEN --username=$DOCKERHUB_USERNAME
aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
aws configure set default.region $REGION
# set -x
# set -e
# https://gist.github.com/tomahim/c640bf8625343135340251faa1179100
# {
#     AWS_CONFIG_FILE=~/.aws/config

#     mkdir ~/.aws
#     touch $AWS_CONFIG_FILE
#     chmod 600 $AWS_CONFIG_FILE

#     echo "[profile eb-cli]"                              > $AWS_CONFIG_FILE
#     echo "aws_access_key_id=${AWS_ACCESS_KEY_ID}"         >> $AWS_CONFIG_FILE
#     echo "aws_secret_access_key=${AWS_SECRET_ACCESS_KEY}" >> $AWS_CONFIG_FILE
# } &> /dev/null