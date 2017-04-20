.PHONY: all cluster stop shell ring provision

# Node that we use to run adhoc commands
ADHOC_NODE=cassandra-0
# Net used to connect to ring and run commands
CLUSTER_NET=cassandraclusterdev_ring_bridge

# 3 node cluster
up:
	docker-compose -f docker-compose.yml up -d --build

# Load some data into the cluster
provision:
	docker cp provision.cql ${ADHOC_NODE}:/provision.cql
	docker exec ${ADHOC_NODE} cqlsh -f provision.cql 

down:
	docker-compose -f docker-compose.yml down

# get a cqlsh shell to run commands
shell:
	docker exec -it ${ADHOC_NODE} cqlsh

# inspect the ring - useful for verifying that gossip is working
ring:
	docker exec ${ADHOC_NODE} nodetool ring
