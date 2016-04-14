#!/bin/sh
mkdir /usr/lib/stormLog  >>/usr/lib/stormLog/logerror
touch /usr/lib/stormLog/logerror
touch /usr/lib/stormLog/logsuccess
# apt-get update 2 >>/usr/lib/stormLog/logerror  1 >>/usr/lib/stormLog/logsuccess
# apt-get --yes install openjdk-7-jdk 2 >>/usr/lib/stormLog/logerror  1 >>/usr/lib/stormLog/logsuccess
# echo "export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk" >> ~/.bashrc
# source ~/.bashrc
# echo $JAVA_HOME >> /usr/lib/stormLog/logsuccess

apt-get --yes install zookeeper  >>/usr/lib/stormLog/logsuccess

groupadd storm   >>/usr/lib/stormLog/logerror
useradd --gid storm --home-dir /home/storm --create-home --shell /bin/bash storm  >>/usr/lib/stormLog/logerror
wget http://apache.cs.utah.edu/storm/apache-storm-0.9.1-incubating/apache-storm-0.9.1-incubating.zip

echo "storm download success" >>  /usr/lib/stormLog/logsuccess

unzip -o apache-storm-0.9.1-incubating.zip -d /usr/share  >>/usr/lib/stormLog/logerror
ln -s /usr/share/apache-storm-0.9.1-incubating /usr/share/storm  >>/usr/lib/stormLog/logerror
ln -s /usr/share/storm/bin/storm /usr/bin/storm  >>/usr/lib/stormLog/logerror


mkdir /etc/storm  >>/usr/lib/stormLog/logerror
chown storm:storm /etc/storm
mv /usr/share/storm/conf/storm.yaml /etc/storm  >>/usr/lib/stormLog/logerror
ln -s /etc/storm/storm.yaml /usr/share/storm/conf/storm.yaml  >>/usr/lib/stormLog/logerror

apt-get --yes install supervisor >>/usr/lib/stormLog/logsuccess

echo "1" > /etc/zookeeper/conf/myid
rm  /etc/zookeeper/conf/zoo.cfg   >>/usr/lib/stormLog/logerror
cp zoo.cfg  /etc/zookeeper/conf/
/usr/share/zookeeper/bin/zkServer.sh start &  >>/usr/lib/stormLog/logerror
echo "zookeeper start success" >>  /usr/lib/stormLog/logsuccess

touch /etc/supervisor/conf.d/storm-nimbus.conf
touch /etc/supervisor/conf.d/storm-supervisor.conf
touch /etc/supervisor/conf.d/storm-ui.conf

rm /etc/supervisor/conf.d/storm-nimbus.conf   >>/usr/lib/stormLog/logerror
rm /etc/supervisor/conf.d/storm-supervisor.conf   >>/usr/lib/stormLog/logerror
rm /etc/supervisor/conf.d/storm-ui.conf   >>/usr/lib/stormLog/logerror


cp storm-nimbus.conf  /etc/supervisor/conf.d/
cp storm-supervisor.conf  /etc/supervisor/conf.d/
cp storm-ui.conf  /etc/supervisor/conf.d/


/etc/init.d/supervisor stop &
/etc/init.d/supervisor start &
echo "supervisor start success" >> /usr/lib/stormLog/logsuccess

rm /etc/storm/storm.yaml  >>/usr/lib/stormLog/logerror
cp storm.yaml /etc/storm/

echo "change storm.yaml success too " >> /usr/lib/stormLog/logsuccess

storm nimbus &
storm supervisor &
storm ui &

echo "open url localhost:8080"
