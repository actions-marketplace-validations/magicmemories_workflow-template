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

#!/usr/bin/env bash

# Login to Kubernetes Cluster.
aws eks \
    --region ${AWS_REGION} \
    update-kubeconfig --name ${CLUSTER_NAME} \
    --role-arn=${CLUSTER_ROLE_ARN}

# Helm Dependency Update
helm dependency update ${DEPLOY_CHART_PATH:-helm/}

# Helm Deployment
UPGRADE_COMMAND="helm upgrade --wait --atomic --install --timeout ${TIMEOUT}"
for config_file in ${DEPLOY_CONFIG_FILES//,/ }
do
    UPGRADE_COMMAND="${UPGRADE_COMMAND} -f ${config_file}"
done
if [ -n "$DEPLOY_NAMESPACE" ]; then
    UPGRADE_COMMAND="${UPGRADE_COMMAND} -n ${DEPLOY_NAMESPACE}"
fi
if [ -n "$DEPLOY_VALUES" ]; then
    UPGRADE_COMMAND="${UPGRADE_COMMAND} --set ${DEPLOY_VALUES}"
fi
UPGRADE_COMMAND="${UPGRADE_COMMAND} ${DEPLOY_NAME} ${DEPLOY_CHART_PATH:-helm/}"
echo "Executing: ${UPGRADE_COMMAND}"
${UPGRADE_COMMAND}