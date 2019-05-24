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
  echo "Terminating logstash"
  service logstash stop
  exit 0
}

trap _term SIGTERM SIGINT


## remove pidfiles in case previous graceful termination failed
# NOTE - This is the reason for the WARNING at the top - it's a bit hackish,
#   but if it's good enough for Fedora (https://goo.gl/88eyXJ), it's good
#   enough for me :)

rm -f /var/run/logstash.pid 

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

### Logstash

if [ -z "$LOGSTASH_START" ]; then
  LOGSTASH_START=1
fi
if [ "$LOGSTASH_START" -ne "1" ]; then
  echo "LOGSTASH_START is set to something different from 1, not starting..."
else
  # override LS_HEAP_SIZE variable if set
  if [ ! -z "$LS_HEAP_SIZE" ]; then
    awk -v LINE="-Xmx$LS_HEAP_SIZE" '{ sub(/^.Xmx.*/, LINE); print; }' ${LOGSTASH_PATH_SETTINGS}/jvm.options \
        > ${LOGSTASH_PATH_SETTINGS}/jvm.options.new && mv ${LOGSTASH_PATH_SETTINGS}/jvm.options.new ${LOGSTASH_PATH_SETTINGS}/jvm.options
    awk -v LINE="-Xms$LS_HEAP_SIZE" '{ sub(/^.Xms.*/, LINE); print; }' ${LOGSTASH_PATH_SETTINGS}/jvm.options \
        > ${LOGSTASH_PATH_SETTINGS}/jvm.options.new && mv ${LOGSTASH_PATH_SETTINGS}/jvm.options.new ${LOGSTASH_PATH_SETTINGS}/jvm.options
  fi

  if [ ! -z "$LS_HEAP_DISABLE" ]; then
    awk -v LINE="#-XX:+HeapDumpOnOutOfMemoryError" '{ sub(/^-XX:\+HeapDumpOnOutOfMemoryError.*/, LINE); print; }' ${LOGSTASH_PATH_SETTINGS}/jvm.options \
        > ${LOGSTASH_PATH_SETTINGS}/jvm.options.new && mv ${LOGSTASH_PATH_SETTINGS}/jvm.options.new ${LOGSTASH_PATH_SETTINGS}/jvm.options
  fi

  # override LS_OPTS variable if set
  if [ ! -z "$LS_OPTS" ]; then
    awk -v LINE="LS_OPTS=\"$LS_OPTS\"" '{ sub(/^LS_OPTS=.*/, LINE); print; }' /etc/init.d/logstash \
        > /etc/init.d/logstash.new && mv /etc/init.d/logstash.new /etc/init.d/logstash && chmod +x /etc/init.d/logstash
  fi

  service logstash start
  OUTPUT_LOGFILES+="/var/log/logstash/logstash-plain.log "
fi

## [MARIO] rehacer este punto

# Exit if nothing has been started
if [ "$ELASTICSEARCH_START" -ne "1" ] && [ "$LOGSTASH_START" -ne "1" ] \
  && [ "$KIBANA_START" -ne "1" ]; then
  >&2 echo "No services started. Exiting."
  exit 1
fi


## run post-hooks
if [ -x /usr/local/bin/elk-post-hooks.sh ]; then
  ### if Kibana was started...
  if [ "$KIBANA_START" -eq "1" ]; then

  ### ... then wait for Kibana to be up first to ensure that .kibana index is
  ### created before the of post-hooks are executed
    # set number of retries (default: 30, override using KIBANA_CONNECT_RETRY env var)
    if ! [[ $KIBANA_CONNECT_RETRY =~ $re_is_numeric ]] ; then
       KIBANA_CONNECT_RETRY=30
    fi

    if [ -z "$KIBANA_URL" ]; then
      KIBANA_URL=http://localhost:5601
    fi

    counter=0
    while [ ! "$(curl ${KIBANA_URL} 2> /dev/null)" -a $counter -lt $KIBANA_CONNECT_RETRY  ]; do
      sleep 1
      ((counter++))
      echo "waiting for Kibana to be up ($counter/$KIBANA_CONNECT_RETRY)"
    done
    if [ ! "$(curl ${KIBANA_URL} 2> /dev/null)" ]; then
      echo "Couln't start Kibana. Exiting."
      echo "Kibana log follows below."
      cat /var/log/kibana/kibana5.log
      exit 1
    fi
  fi

  . /usr/local/bin/elk-post-hooks.sh
fi


touch $OUTPUT_LOGFILES
tail -f $OUTPUT_LOGFILES &
wait
