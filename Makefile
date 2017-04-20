.PHONY: all cluster stop shell ring provision

CASSANDRA_IMAGE=cassandra_custom
# Node that we use to run adhoc commands
ADHOC_NODE=cassandra-0
# Net used to connect to ring and run commands
CLUSTER_NET=cassandracustom_ring_bridge

# 3 node cluster
up:
	docker-compose -f ${CASSANDRA_IMAGE}/docker-compose.yml up -d --build

# Load some data into the cluster
provision:
	docker build -t cassandra_provision cassandra_provision
	docker run --rm --net ${CLUSTER_NET} cassandra_provision

down:
	docker-compose -f ${CASSANDRA_IMAGE}/docker-compose.yml down

# get a cqlsh shell to run commands
shell:
	docker run --rm -it --net ${CLUSTER_NET} ${CASSANDRA_IMAGE} cqlsh ${ADHOC_NODE}

# inspect the ring - useful for verifying that gossip is working
ring:
	docker exec ${ADHOC_NODE} nodetool ring
