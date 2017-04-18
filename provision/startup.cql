CREATE KEYSPACE IF NOT EXISTS Logs
WITH REPLICATION = { 
    'class' : 'SimpleStrategy',
    'replication_factor' : 3
};

USE Logs;

CREATE TABLE RequestLogs (
    service text,
    endpoint text,
    date text,
    request_ts timestamp,
    ip text,
    body blob,
    headers blob,
    PRIMARY KEY ((service, endpoint, date), request_ts)
);
