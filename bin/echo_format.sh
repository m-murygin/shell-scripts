#!/bin/bash

host_name=$(hostname)
host_name=${host_name,,}

bucket="$host_name"
datastore="isolated_${host_name}"

isolated_config=$(cat <<EOF
{
    "isolated": {
        "hostname": "http://localhost",
        "gcloud": {
            "bucketname": "BUCKET",
            "datastore": "DATASTORE"
        },
    }
}
EOF
)

echo "$isolated_config" | m4 -DBUCKET=$bucket -DDATASTORE=$datastore
