$CONJUR_AUTHENTICATOR_ID = "onprem-demok8cluster"
$HOSTS_IDENTITY_PATH = "data/jwt-hosts/k8/onprem/$CONJUR_AUTHENTICATOR_ID"

$SA_ISSUER = $(kubectl get --raw /.well-known/openid-configuration | ConvertFrom-Json).issuer

$JWKS = $(kubectl get --raw $(kubectl get --raw /.well-known/openid-configuration | ConvertFrom-Json).jwks_uri) | ConvertTo-Json

$PUB_KEYS = @"
 {
  \"type\":\"jwks\", \"value\":$($JWKS)
 }
"@
#conjur variable set -i conjur/authn-jwt/aws-eks-cluster/public-keys -v $gh

conjur variable set -i conjur/authn-jwt/$CONJUR_AUTHENTICATOR_ID/issuer -v $SA_ISSUER
conjur variable set -i conjur/authn-jwt/$CONJUR_AUTHENTICATOR_ID/token-app-property -v "sub"
conjur variable set -i conjur/authn-jwt/$CONJUR_AUTHENTICATOR_ID/identity-path -v $HOSTS_IDENTITY_PATH
conjur variable set -i conjur/authn-jwt/$CONJUR_AUTHENTICATOR_ID/audience -v "conjur"
conjur variable set -i conjur/authn-jwt/$CONJUR_AUTHENTICATOR_ID/public-keys -v $PUB_KEYS
#conjur variable set -i conjur/authn-jwt/$CONJUR_AUTHENTICATOR_ID/public-keys -v "{\"type\":\"jwks\", \"value\":$(cat jwks.json)}"