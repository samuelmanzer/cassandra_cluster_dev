.PHONY: all build cluster stop clean shell ring provision

all: cluster

build:
	docker build -t custom_cassandra cassandra_image 
	docker build -t cassandra_provision provision

# 3 node cluster
cluster:
	# Start nodes and allow them to gossip
	docker run -d --name node_0\
		--link graphite:graphite\
		custom_cassandra
	docker run -d --name node_1\
		--link graphite:graphite\
	   	--link node_0:cassandra\
		custom_cassandra 
	docker run -d --name node_2\
		--link graphite:graphite\
	   	--link node_0:cassandra\
		custom_cassandra 

provision: build
	docker run --rm --link node_0:cassandra cassandra_provision

stop:
	docker stop node_0
	docker stop node_1
	docker stop node_2

clean: stop
	docker rm node_0
	docker rm node_1
	docker rm node_2

# this relies on the /etc/hosts file added by docker for linked containers
shell:
	docker run --rm -it --link node_0:cassandra cassandra cqlsh cassandra

ring:
	docker exec node_0 nodetool ring
