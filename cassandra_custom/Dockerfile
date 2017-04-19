FROM cassandra:3.0

ADD metrics-graphite-3.1.2.jar /usr/share/cassandra/lib/

ADD metrics_reporter_graphite.yaml /etc/cassandra/

ENV METRICS_REPORTER_CFG "metrics_reporter_graphite.yaml"
ENV JVM_OPTS "$JVM_OPTS -Dcassandra.metricsReporterConfigFile=$METRICS_REPORTER_CFG"
