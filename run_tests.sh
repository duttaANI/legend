#! /bin/sh

set -ex

export LEGEND_HOME=/tmp/.legend 

# Create a new key for Grafana and export as environment variable
sleep 5
GRAFANA_URL="${GRAFANA_PROTOCOL}://${GRAFANA_HOST}"

GRAFANA_API_KEY=$(curl -s -X POST -H "Content-Type: application/json" \
    -d '{"name":"tests-token", "role": "Admin"}' \
    $GRAFANA_URL/api/auth/keys | jq .key | tr -d \" )

export GRAFANA_API_KEY=$GRAFANA_API_KEY

# Run tests
legend configure 

legend build sample_input.yaml -o sample_output.json -s

# legend apply (also tests the folder creation flow)
legend publish sample_output.json -f SampleFolder 

# TODO: deleting the sampleFolder and sample dashbaord

# TODO: verify input and expected output files
