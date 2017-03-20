#!/bin/sh

docker stop efkmaster_es_1  >/dev/null 2>&1
docker stop efkmaster_fluentd_1  >/dev/null 2>&1
docker stop efkmaster_kibana_1 >/dev/null 2>&1
docker rm efkmaster_es_1  >/dev/null 2>&1
docker rm efkmaster_fluentd_1  >/dev/null 2>&1
docker rm efkmaster_kibana_1 >/dev/null 2>&1

docker run -d -p 9200:9200 -p 9300:9300 -v /data/docker/es:/usr/share/elasticsearch/data --name=efkmaster_es_1 192.168.99.100:5000/elasticsearch:2
sleep 1
docker run -d --name=efkmaster_fluentd_1 -p 24224:24224 --link=efkmaster_es_1:es 192.168.99.100:5000/efkmaster_fluentd
sleep 1
docker run -d --name=efkmaster_kibana_1 -p 5601:5601 --link=efkmaster_es_1:elasticsearch 192.168.99.100:5000/kibana:4
docker ps
