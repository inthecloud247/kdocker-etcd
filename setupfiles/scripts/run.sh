#!/bin/bash

ES_HOST=${ES_HOST:-127.0.0.1}
ES_PORT=${ES_PORT:-9200}
ES_CLUSTER=${ES_CLUSTER:-elasticsearch}

cat << EOF > /etc/hekad/elasticsearch.toml
[ElasticSearchOutput]
message_matcher = "Type == 'sync.log'"
cluster = "$ES_CLUSTER"
index = "synclog-%{2006.01.02.15.04.05}"
type_name = "sync.log.line"
server = "http://$ES_HOST:$ES_PORT"
format = "clean"
flush_interval = 5000
flush_count = 10
EOF

etcd