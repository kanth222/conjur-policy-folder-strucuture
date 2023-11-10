$CONJUR_ACCOUNT = "atltestinglab"
$CONJUR_AUTHENTICATOR_ID = "onprem-demok8cluster"
$CONJUR_MASTER_HOSTNAME="conjur-leader.atlanta.testing-labs.net"
$CYBERARK_CONJUR_APPLIANCE_URL="https://${CONJUR_MASTER_HOSTNAME}/api"
$CONJUR_CERT_FILE = "./conjur-onprem.pem"
#To get conjur_cert_file using openssl run below command
#openssl s_client -showcerts -servername conjur-leader.atlanta.testing-labs.net -connect conjur-leader.atlanta.testing-labs.net:443 </dev/null | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > conjur-onprem.pem

$APP_NAMESPACE = "demo-app-namespace"

#If namespace novt avilable run below command to create one
#kubectl create ns demo-app-namespace

kubectl config set-context --current --namespace="$APP_NAMESPACE"

kubectl delete serviceaccount demo-app-sa --ignore-not-found=true
kubectl create serviceaccount demo-app-sa

kubectl delete configmap conjur-connect --ignore-not-found=true

kubectl create configmap conjur-connect `
  --from-literal CONJUR_ACCOUNT="$CONJUR_ACCOUNT" `
  --from-literal CONJUR_APPLIANCE_URL="$CYBERARK_CONJUR_APPLIANCE_URL" `
  --from-literal CONJUR_AUTHN_URL="$CYBERARK_CONJUR_APPLIANCE_URL"/authn-jwt/"$CONJUR_AUTHENTICATOR_ID" `
  --from-literal AUTHENTICATOR_ID="$CONJUR_AUTHENTICATOR_ID" `
  --from-literal CONJUR_AUTHN_JWT_SERVICE_ID="$CONJUR_AUTHENTICATOR_ID" `
  --from-literal MY_POD_NAMESPACE="$APP_NAMESPACE" `
  --from-file CONJUR_SSL_CERTIFICATE="$CONJUR_CERT_FILE"


kubectl delete configmap nodejs-db-templates --ignore-not-found=true
kubectl create configmap nodejs-db-templates --from-file=demo-app.tpl


  kubectl apply -f deployment.yaml