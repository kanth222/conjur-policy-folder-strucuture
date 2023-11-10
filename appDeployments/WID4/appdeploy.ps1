
$APP_NAMESPACE = "demo-app-namespace"
$SA_ACCOUNT = "demo-app-sa"

$env:variables = @{
    "APP_NAMESPACE" = $APP_NAMESPACE;
    "SA_ACCOUNT" = $SA_ACCOUNT
}

$deployment = Get-Content deployment.yaml -Raw
foreach ($key in $variables.Keys) {
    # write-host "'$'+$key"
    # $deployment = $deployment.Replace("$'$key'", $variables[$key])
    # #$deployment = $deployment.Replace($$key, $variables[$key])
    $variablePattern = [regex]::Escape('$' + "{{$key}}")
    $deployment = [System.Text.RegularExpressions.Regex]::Replace($deployment, $variablePattern, $variables[$key])
}
$deployment | Set-Content -Path deployment_modified.yml.tmp

#kubectl apply -f deployment_modified.yml

