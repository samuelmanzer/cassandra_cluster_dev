# 3 node cluster
all:
	docker run -d --name node_0 cassandra:3.0
	docker run -d --name node_1 cassandra:3.0 --link node_0:cassandra
	docker run -d --name node_2 cassandra:3.0 --link node_0:cassandra
stop:
	docker stop node_0
	docker stop node_1
	docker stop node_2
clean:
	docker rm node_0
	docker rm node_1
	docker rm node_2

# this relies on the /etc/hosts file added by docker for linked containers
shell:
	docker run --rm -it --link node_0:cassandra cassandra cqlsh cassandra
