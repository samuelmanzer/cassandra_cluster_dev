// Create and use keyspace for logging data
CREATE KEYSPACE IF NOT EXISTS Logs
WITH REPLICATION = { 
    'class' : 'SimpleStrategy',
    'replication_factor' : 3
};

USE Logs;

// Create table to hold http request logs
CREATE TABLE IF NOT EXISTS request_logs (
    service text,
    endpoint text,
    date text,
    request_ts timestamp,
    ip text,
    body text,
    headers text,
    PRIMARY KEY ((service, endpoint, date), request_ts)
);

// Populate with a token value
INSERT INTO request_logs (
    service,
    endpoint,
    date,
    request_ts,
    body,
    headers,
    ip
) VALUES (
    'my_service',
    'my_endpoint',
    '2017-04-18',
    dateof(now()),
    'the body',
    'the headers',
    '2602:306:807d:d320:8d80:9f6:18d4:1b38'
);
