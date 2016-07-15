#!/bin/bash

host_name=$(hostname)
host_name=${host_name,,}

bucket="$host_name"
datastore="isolated_${host_name}"

function string_replace {
     #DOC: "${string/match/replace}"
     string="$1"
     echo "${string/$2/$3}"
 }

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

isolated_config=$(string_replace "$isolated_config" BUCKET "$bucket")
isolated_config=$(string_replace "$isolated_config" DATASTORE "$datastore")

echo "$isolated_config"