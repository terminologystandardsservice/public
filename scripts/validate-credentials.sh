#!/bin/bash

# Get the token
json=$(curl POST "https://terminologystandardsservice.ca/authorisation/auth/realms/terminology/protocol/openid-connect/token" \
--data-urlencode "grant_type=client_credentials" \
--data-urlencode "client_id=<client-id>" \
--data-urlencode "client_secret=<client-secret>")

access_token=$(echo $json | jq -r .access_token)

echo $access_token

# Use the token to list all valuesets
curl "https://terminologystandardsservice.ca/fhir/ValueSet" \
	--header "Authorization: Bearer $access_token" | jq

echo "Done."
