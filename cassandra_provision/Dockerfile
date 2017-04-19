FROM cassandra:3.0

WORKDIR /config

ADD . /config

CMD ["cqlsh",  "cassandra", "-f", "/config/startup.cql"]
