#!/bin/bash
#
# /usr/local/bin/start.sh
# Start Elasticsearch, Logstash and Kibana services
#
# spujadas 2015-10-09; added initial pidfile removal and graceful termination

# WARNING - This script assumes that the ELK services are not running, and is
#   only expected to be run once, when the container is started.
#   Do not attempt to run this script if the ELK services are running (or be
#   prepared to reap zombie processes).


## handle termination gracefully

_term() {
  echo "Terminating elastic"
  service elasticsearch stop
  exit 0
}

trap _term SIGTERM SIGINT


## remove pidfiles in case previous graceful termination failed
# NOTE - This is the reason for the WARNING at the top - it's a bit hackish,
#   but if it's good enough for Fedora (https://goo.gl/88eyXJ), it's good
#   enough for me :)

rm -f /var/run/elasticsearch/elasticsearch.pid

## initialise list of log files to stream in console (initially empty)
OUTPUT_LOGFILES=""


## override default time zone (Etc/UTC) if TZ variable is set
if [ ! -z "$TZ" ]; then
  ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
fi


## run pre-hooks
if [ -x /usr/local/bin/elk-pre-hooks.sh ]; then
  . /usr/local/bin/elk-pre-hooks.sh
fi


## start services as needed

### crond

service cron start


### Elasticsearch

if [ -z "$ELASTICSEARCH_START" ]; then
  ELASTICSEARCH_START=1
fi
if [ "$ELASTICSEARCH_START" -ne "1" ]; then
  echo "ELASTICSEARCH_START is set to something different from 1, not starting..."
else
  # update permissions of ES data directory
  chown -R elasticsearch:elasticsearch /var/lib/elasticsearch

  # override ES_HEAP_SIZE variable if set
  if [ ! -z "$ES_HEAP_SIZE" ]; then
    awk -v LINE="-Xmx$ES_HEAP_SIZE" '{ sub(/^.Xmx.*/, LINE); print; }' ${ES_PATH_CONF}/jvm.options \
        > ${ES_PATH_CONF}/jvm.options.new && mv ${ES_PATH_CONF}/jvm.options.new ${ES_PATH_CONF}/jvm.options
    awk -v LINE="-Xms$ES_HEAP_SIZE" '{ sub(/^.Xms.*/, LINE); print; }' ${ES_PATH_CONF}/jvm.options \
        > ${ES_PATH_CONF}/jvm.options.new && mv ${ES_PATH_CONF}/jvm.options.new ${ES_PATH_CONF}/jvm.options
  fi

  if [ ! -z "$ES_HEAP_DISABLE" ]; then
    awk -v LINE="#-XX:+HeapDumpOnOutOfMemoryError" '{ sub(/^-XX:\+HeapDumpOnOutOfMemoryError.*/, LINE); print; }' ${ES_PATH_CONF}/jvm.options \
        > ${ES_PATH_CONF}/jvm.options.new && mv ${ES_PATH_CONF}/jvm.options.new ${ES_PATH_CONF}/jvm.options
  fi

  # override ES_JAVA_OPTS variable if set
  if [ ! -z "$ES_JAVA_OPTS" ]; then
    awk -v LINE="ES_JAVA_OPTS=\"$ES_JAVA_OPTS\"" '{ sub(/^#?ES_JAVA_OPTS=.*/, LINE); print; }' /etc/default/elasticsearch \
        > /etc/default/elasticsearch.new && mv /etc/default/elasticsearch.new /etc/default/elasticsearch
  fi

  # override MAX_OPEN_FILES variable if set
  if [ ! -z "$MAX_OPEN_FILES" ]; then
    awk -v LINE="MAX_OPEN_FILES=$MAX_OPEN_FILES" '{ sub(/^#?MAX_OPEN_FILES=.*/, LINE); print; }' /etc/init.d/elasticsearch \
        > /etc/init.d/elasticsearch.new && mv /etc/init.d/elasticsearch.new /etc/init.d/elasticsearch \
        && chmod +x /etc/init.d/elasticsearch
  fi

  # override MAX_MAP_COUNT variable if set
  if [ ! -z "$MAX_MAP_COUNT" ]; then
    awk -v LINE="MAX_MAP_COUNT=$MAX_MAP_COUNT" '{ sub(/^#?MAX_MAP_COUNT=.*/, LINE); print; }' /etc/init.d/elasticsearch \
        > /etc/init.d/elasticsearch.new && mv /etc/init.d/elasticsearch.new /etc/init.d/elasticsearch \
        && chmod +x /etc/init.d/elasticsearch
  fi

  service elasticsearch start

#   # wait for Elasticsearch to start up before either starting Kibana (if enabled)
#   # or attempting to stream its log file
#   # - https://github.com/elasticsearch/kibana/issues/3077

#   # set number of retries (default: 30, override using ES_CONNECT_RETRY env var)
#   re_is_numeric='^[0-9]+$'
#   if ! [[ $ES_CONNECT_RETRY =~ $re_is_numeric ]] ; then
#      ES_CONNECT_RETRY=30
#   fi

#   if [ -z "$ELASTICSEARCH_URL" ]; then
#     ELASTICSEARCH_URL=${ES_PROTOCOL:-http}://localhost:9200
#   fi

#   counter=0
#   while [ ! "$(curl -k ${ELASTICSEARCH_URL} 2> /dev/null)" -a $counter -lt $ES_CONNECT_RETRY  ]; do
#     sleep 1
#     ((counter++))
#     echo "waiting for Elasticsearch to be up ($counter/$ES_CONNECT_RETRY)"
#   done
#   if [ ! "$(curl -k ${ELASTICSEARCH_URL} 2> /dev/null)" ]; then
#     echo "Couln't start Elasticsearch. Exiting."
#     echo "Elasticsearch log follows below."
#     cat /var/log/elasticsearch/elasticsearch.log
#     exit 1
#   fi

#   # wait for cluster to respond before getting its name
#   counter=0
#   while [ -z "$CLUSTER_NAME" -a $counter -lt 30 ]; do
#     sleep 1
#     ((counter++))
#     CLUSTER_NAME=$(curl -k ${ELASTICSEARCH_URL}/_cat/health?h=cluster 2> /dev/null | tr -d '[:space:]')
#     echo "Waiting for Elasticsearch cluster to respond ($counter/30)"
#   done
#   if [ -z "$CLUSTER_NAME" ]; then
#     echo "Couln't get name of cluster. Exiting."
#     echo "Elasticsearch log follows below."
#     cat /var/log/elasticsearch/elasticsearch.log
#     exit 1
#   fi
#   OUTPUT_LOGFILES+="/var/log/elasticsearch/${CLUSTER_NAME}.log "
# fi

# ## run post-hooks
# if [ -x /usr/local/bin/elk-post-hooks.sh ]; then
#   ### if Kibana was started...

#   ### [MARIO] Completar con nuevo KIBANA_START
#   if [ "$KIBANA_START" -eq "1" ]; then

#   ### ... then wait for Kibana to be up first to ensure that .kibana index is
#   ### created before the of post-hooks are executed
#     # set number of retries (default: 30, override using KIBANA_CONNECT_RETRY env var)
#     if ! [[ $KIBANA_CONNECT_RETRY =~ $re_is_numeric ]] ; then
#        KIBANA_CONNECT_RETRY=30
#     fi

#     if [ -z "$KIBANA_URL" ]; then
#       KIBANA_URL=http://localhost:5601
#     fi

#     counter=0
#     while [ ! "$(curl ${KIBANA_URL} 2> /dev/null)" -a $counter -lt $KIBANA_CONNECT_RETRY  ]; do
#       sleep 1
#       ((counter++))
#       echo "waiting for Kibana to be up ($counter/$KIBANA_CONNECT_RETRY)"
#     done
#     if [ ! "$(curl ${KIBANA_URL} 2> /dev/null)" ]; then
#       echo "Couln't start Kibana. Exiting."
#       echo "Kibana log follows below."
#       cat /var/log/kibana/kibana5.log
#       exit 1
#     fi
#   fi

#   . /usr/local/bin/elk-post-hooks.sh
# fi

fi

ELASTICSEARCH_URL=${ES_PROTOCOL:-http}://localhost:9200
CLUSTER_NAME=$(curl -k ${ELASTICSEARCH_URL}/_cat/health?h=cluster 2> /dev/null | tr -d '[:space:]')
OUTPUT_LOGFILES+="/var/log/elasticsearch/${CLUSTER_NAME}.log "

touch $OUTPUT_LOGFILES
tail -f $OUTPUT_LOGFILES &
wait
