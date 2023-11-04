$CONJUR_AUTHENTICATOR_ID = "AWS-AA1234-USEAST1-k8cluster1"
$HOSTS_IDENTITY_PATH = "data/jwt-hosts/k8/aws/$CONJUR_AUTHENTICATOR_ID"
$SA_ISSUER = ""
$JWKS_URI = ""
#$SA_ISSUER = $(kubectl get --raw /.well-known/openid-configuration | ConvertFrom-Json).issuer

#$JWKS = $(kubectl get --raw $(kubectl get --raw /.well-known/openid-configuration | ConvertFrom-Json).jwks_uri) | ConvertTo-Json

conjur variable set -i conjur/authn-jwt/$CONJUR_AUTHENTICATOR_ID/issuer -v $SA_ISSUER
conjur variable set -i conjur/authn-jwt/$CONJUR_AUTHENTICATOR_ID/token-app-property -v "sub"
conjur variable set -i conjur/authn-jwt/$CONJUR_AUTHENTICATOR_ID/identity-path -v $HOSTS_IDENTITY_PATH
conjur variable set -i conjur/authn-jwt/$CONJUR_AUTHENTICATOR_ID/audience -v "conjur"
conjur variable set -i conjur/authn-jwt/$CONJUR_AUTHENTICATOR_ID/jwks-uri -v $JWKS_URI
#conjur variable set -i conjur/authn-jwt/$CONJUR_AUTHENTICATOR_ID/public-keys -v "{\"type\":\"jwks\", \"value\":$(cat jwks.json)}"