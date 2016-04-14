#! /bin/sh
mkdir kafka02
cd kafka02
#the 0.9.0.0 release and un-tar it.
wget http://mirrors.hust.edu.cn/apache/kafka/0.9.0.1/kafka_2.10-0.9.0.1.tgz
tar -xzf kafka_2.10-0.9.0.1.tgz
cd kafka_2.11-0.9.0.0
#Start the server
bin/zookeeper-server-start.sh config/zookeeper.properties
#Now start the Kafka server: 
bin/kafka-server-start.sh config/server.properties
#create a topic named "test" with a single partition and only one replica:
bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic test
bin/kafka-topics.sh --list --zookeeper localhost:2181


