$CONJUR_AUTHENTICATOR_ID = "GKE-US_EAST1_ihg-conjur-k8"
$HOSTS_IDENTITY_PATH = "data/IHG/demo-apps"
$SA_ISSUER = "https://container.googleapis.com/v1/projects/ihg-conjur/locations/us-east1-b/clusters/ihg-conjur-k8"
$JWKS_URI = "https://container.googleapis.com/v1/projects/ihg-conjur/locations/us-east1-b/clusters/ihg-conjur-k8/jwks"
#$SA_ISSUER = $(kubectl get --raw /.well-known/openid-configuration | ConvertFrom-Json).issuer

#$JWKS = $(kubectl get --raw $(kubectl get --raw /.well-known/openid-configuration | ConvertFrom-Json).jwks_uri) | ConvertTo-Json

conjur variable set -i conjur/authn-jwt/$CONJUR_AUTHENTICATOR_ID/issuer -v $SA_ISSUER
conjur variable set -i conjur/authn-jwt/$CONJUR_AUTHENTICATOR_ID/token-app-property -v "sub"
conjur variable set -i conjur/authn-jwt/$CONJUR_AUTHENTICATOR_ID/identity-path -v $HOSTS_IDENTITY_PATH
conjur variable set -i conjur/authn-jwt/$CONJUR_AUTHENTICATOR_ID/audience -v "conjur"
conjur variable set -i conjur/authn-jwt/$CONJUR_AUTHENTICATOR_ID/jwks-uri -v $JWKS_URI
#conjur variable set -i conjur/authn-jwt/$CONJUR_AUTHENTICATOR_ID/public-keys -v "{\"type\":\"jwks\", \"value\":$(cat jwks.json)}"

conjur authenticator enable --id authn-jwt/$CONJUR_AUTHENTICATOR_ID