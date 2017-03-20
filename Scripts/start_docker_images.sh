#!/bin/sh

docker stop $(docker ps -aq) >/dev/null 2>&1
docker rm $(docker ps -aq) >/dev/null 2>&1

cd /home/core/fluentd-boot-master/
docker-compose up -d
sleep 5

docker run -d -p 8012:8012 -e "SPRING_PROFILES_ACTIVE=qatrunk" --log-driver=fluentd --log-opt fluentd-address=10.7.112.75:24224 --log-opt fluentd-tag="{{.Name}}/{{.ID}}" --restart=always --name "NantOS_Discovery" -t 10.100.105.7:5000/discovery-server
sleep 5

docker run -d -p 8443:8443 -e "SPRING_PROFILES_ACTIVE=qatrunk" --log-driver=fluentd --log-opt fluentd-address=10.7.112.75:24224 --log-opt fluentd-tag="{{.Name}}/{{.ID}}" --restart=always --name "NantOS_Gateway" -t 10.100.105.7:5000/gateway-server
sleep 5

docker run -d -p 8014:8014 -e "SPRING_PROFILES_ACTIVE=qatrunk" --log-driver=fluentd --log-opt fluentd-address=10.7.112.75:24224 --log-opt fluentd-tag="{{.Name}}/{{.ID}}" --restart=always --name "NantOS_Documentation" -t 10.100.105.7:5000/documentation-server
sleep 5

docker run -d -p 8050:8050 -e "SPRING_PROFILES_ACTIVE=qatrunk" --log-driver=fluentd --log-opt fluentd-address=10.7.112.75:24224 --log-opt fluentd-tag="{{.Name}}/{{.ID}}" --restart=always --name "NantOS_Vitals" -t 10.100.105.7:5000/ms-vitals
sleep 5

docker ps -a
