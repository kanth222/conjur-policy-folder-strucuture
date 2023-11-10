# # # CONJUR_MASTER_HOSTNAME=atltestinglabs.secretsmgr.cyberark.cloud
# # # CONJUR_MASTER_PORT=443
# # # CYBERARK_CONJUR_APPLIANCE_URL=https://${CONJUR_MASTER_HOSTNAME}/api

# # # $CONJUR_ACCOUNT=conjur

# # # CONJUR_CERT_FILE=

# # # #CONJUR_JWT_TOKEN_PATH=/Users/Badr.NassLahsen/Documents/workspace/conjur-spring-boot-demos/src/test/resources/jwt.json
# # # CONJUR_AUTHENTICATOR_ID=GKE-US_EAST1_ihg-conjur-k8
# # # APP_NAMESPACE=demo-app-ns


# # kubectl config set-context --current --namespace="$APP_NAMESPACE"

# # kubectl delete serviceaccount demo-app-sa --ignore-not-found=true
# # kubectl create serviceaccount demo-app-sa

# # kubectl delete configmap nodejs-db-templates --ignore-not-found=true
# # kubectl create configmap nodejs-db-templates --from-file=demo-app.tpl

# # # DEPLOYMENT
# # envsubst < deployment.yaml | kubectl replace --force -f -
# # if ! kubectl wait deployment demo-nodejs-app-push-to-file --for condition=Available=True --timeout=90s
# #   then exit 1
# # fi

# # kubectl get services demo-nodejs-app-push-to-file
# # kubectl get pods

# $CONJUR_ACCOUNT = "atltestinglab"
# $CONJUR_AUTHENTICATOR_ID = "onprem-demok8cluster"
# $CONJUR_MASTER_HOSTNAME="conjur-leader.atlanta.testing-labs.net"
# $CYBERARK_CONJUR_APPLIANCE_URL="https://${CONJUR_MASTER_HOSTNAME}/api"
# $CONJUR_CERT_FILE = "./conjur-onprem.pem"
# #To get conjur_cert_file using openssl run below command
# #openssl s_client -showcerts -servername atltestinglabs.secretsmgr.cyberark.cloud -connect atltestinglabs.secretsmgr.cyberark.cloud:443 </dev/null | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > conjur-cloud.pem

# $APP_NAMESPACE = "demo-app-namespace"

# #If namespace novt avilable run below command to create one
# #kubectl create ns demo-app-namespace

# kubectl config set-context --current --namespace="$APP_NAMESPACE"

# kubectl delete serviceaccount demo-app-sa --ignore-not-found=true
# kubectl create serviceaccount demo-app-sa

# kubectl delete configmap conjur-connect --ignore-not-found=true

# kubectl create configmap conjur-connect `
#   --from-literal CONJUR_ACCOUNT="$CONJUR_ACCOUNT" `
#   --from-literal CONJUR_APPLIANCE_URL="$CYBERARK_CONJUR_APPLIANCE_URL" `
#   --from-literal CONJUR_AUTHN_URL="$CYBERARK_CONJUR_APPLIANCE_URL"/authn-jwt/"$CONJUR_AUTHENTICATOR_ID" `
#   --from-literal AUTHENTICATOR_ID="$CONJUR_AUTHENTICATOR_ID" `
#   --from-literal CONJUR_AUTHN_JWT_SERVICE_ID="$CONJUR_AUTHENTICATOR_ID" `
#   --from-literal MY_POD_NAMESPACE="$APP_NAMESPACE" `
#   --from-file CONJUR_SSL_CERTIFICATE="$CONJUR_CERT_FILE"


# kubectl delete configmap nodejs-db-templates --ignore-not-found=true
# kubectl create configmap nodejs-db-templates --from-file=demo-app.tpl


#   kubectl apply -f deployment.yaml


CONJUR_MASTER_HOSTNAME=atltestinglabs.secretsmgr.cyberark.cloud
CONJUR_MASTER_PORT=443
CYBERARK_CONJUR_APPLIANCE_URL=https://${CONJUR_MASTER_HOSTNAME}/api

CONJUR_ACCOUNT=conjur

CONJUR_CERT_FILE=conjur.pem
CONJUR_AUTHENTICATOR_ID=GKE-US_EAST1_ihg-conjur-k8
APP_NAMESPACE=demo-app-ns


kubectl config set-context --current --namespace="$APP_NAMESPACE"

kubectl delete configmap conjur-connect --ignore-not-found=true

kubectl create configmap conjur-connect \
  --from-literal CONJUR_ACCOUNT="$CONJUR_ACCOUNT" \
  --from-literal CONJUR_APPLIANCE_URL="$CYBERARK_CONJUR_APPLIANCE_URL" \
  --from-literal CONJUR_AUTHN_URL="$CYBERARK_CONJUR_APPLIANCE_URL"/authn-jwt/"$CONJUR_AUTHENTICATOR_ID" \
  --from-literal AUTHENTICATOR_ID="$CONJUR_AUTHENTICATOR_ID" \
  --from-literal CONJUR_AUTHN_JWT_SERVICE_ID="$CONJUR_AUTHENTICATOR_ID" \
  --from-literal MY_POD_NAMESPACE="$APP_NAMESPACE" \
  --from-file CONJUR_SSL_CERTIFICATE="$CONJUR_CERT_FILE"

kubectl delete serviceaccount test-app-sa --ignore-not-found=true
kubectl create serviceaccount test-app-sa

kubectl delete configmap nodejs-db-templates --ignore-not-found=true
kubectl create configmap nodejs-db-templates --from-file=demo-app.tpl

# DEPLOYMENT
envsubst < deployment.yaml | kubectl replace --force -f -
if ! kubectl wait deployment demo-nodejs-app-push-to-file --for condition=Available=True --timeout=90s
  then exit 1
fi

kubectl get services demo-nodejs-app-push-to-file
kubectl get pods