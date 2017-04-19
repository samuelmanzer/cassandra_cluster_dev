.PHONY: all cluster stop shell ring provision

# Special node we use to seed gossip and to connect to
SEED_NODE=cassandra-0
# Compose creates a separate network, we need name for --link
CLUSTER_NET=cassandraimage_default

all: cluster

# 3 node cluster
cluster:
	docker-compose -f cassandra_image/docker-compose.yml up -d

# Load some data into the cluster
provision:
	docker build -t cassandra_provision provision
	docker run --rm --link ${SEED_NODE}:cassandra --net ${CLUSTER_NET} cassandra_provision

stop:
	docker-compose -f cassandra_image/docker-compose.yml down 

# get a cqlsh shell to run commands
shell:
	docker run --rm -it --link ${SEED_NODE}:cassandra --net ${CLUSTER_NET} custom_cassandra cqlsh cassandra

# inspect the ring - useful for verifying that gossip is working
ring:
	docker exec ${SEED_NODE} nodetool ring
