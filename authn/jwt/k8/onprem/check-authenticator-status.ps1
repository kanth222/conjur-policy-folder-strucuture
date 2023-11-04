$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")
$headers.Add("Accept-Encoding", "base64")

$body = @"
MySecretP@ss1
"@

$response = Invoke-RestMethod 'https://conjur-leader.atlanta.testing-labs.net/api/authn/atltestinglab/admin/authenticate' -Method 'POST' -Headers $headers -Body $body
$response | ConvertTo-Json

$2header = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$2header.Add("Token", "token=$response")
$auth_status = Invoke-RestMethod 'https://conjur-leader.atlanta.testing-labs.net/authn-jwt/onprem-demok8cluster/atltestinglab/status' -Method 'GET' -Headers $2header
$auth_status