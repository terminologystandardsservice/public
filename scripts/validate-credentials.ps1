# Get the token
$headers = @{
    "Content-Type" = "application/x-www-form-urlencoded"
}

$body = @{
    "grant_type"    = "client_credentials"
    "client_id"     = "<client-id>"
    "client_secret" = "<client-secret>"
}

$response = Invoke-RestMethod -Uri "https://terminologystandardsservice.ca/authorisation/auth/realms/terminology/protocol/openid-connect/token" `
    -Method Post -Headers $headers -Body $body

$access_token = $response.access_token

Write-Output $access_token

# Use the token to list all valuesets
$valuesets = Invoke-RestMethod -Uri "https://terminologystandardsservice.ca/fhir/ValueSet" `
    -Headers @{ "Authorization" = "Bearer $access_token" }

# A file is created with the output called "valuesets.json"
$valuesets | ConvertTo-Json | Out-File "valuesets.json"

Write-Output $valuesets
Write-Output "Done."