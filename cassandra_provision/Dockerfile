FROM cassandra:3.0

WORKDIR /config

ADD . /config

CMD ["cqlsh",  "cassandra-0", "-f", "/config/startup.cql"]
