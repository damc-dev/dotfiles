service_name="$1"
while read json; do
        curl -XPUT -d $json http://localhost:8500/v1/catalog/deregister
done < <(curl http://localhost:8500/v1/catalog/service/${service_name} | jq -c ".[]" | tr -d \')