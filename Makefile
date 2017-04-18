all:
	docker run -d --name node_0 cassandra:3.0
stop:
	docker stop node_0
clean:
	docker rm node_0
