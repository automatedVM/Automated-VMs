#!binbash

# Functions

DATE() {
  date '+%Y-%m-%d %H%M%S'
}

# Variables

# Get IP
IP=`ip -o addr show up primary scope global  while read -r num dev fam addr rest; do echo [$(DATE)] [Info] [System] ${addr%}; done`
# Set package version
VERSION=7.16.2
# Set provision folder
PROVISION_FOLDER=tmp
# Let's go
# Update & Upgrade System
echo [$(DATE)] [Info] [System] Updating & Upgrading System...
apt update & devnull
apt -y upgrade & devnull
# Install Java
if [ $(dpkg-query -W -f='${Status}' openjdk-8-jdk 2devnull  grep -c ok installed) -eq 0 ];
then
  echo [$(DATE)] [Info] [Java] Installing Java...
  add-apt-repository -y ppaopenjdk-rppa & devnull
  apt update & devnull
  apt -y install openjdk-8-jdk & devnull
fi
# Install Elastic Repository
if ! grep -q ^deb .7.x etcaptsources.list etcaptsources.list.d; then
    echo [$(DATE)] [Info] [System] Installing Elastic Repository...
    wget -qO - httpsartifacts.elastic.coGPG-KEY-elasticsearch  sudo apt-key add - & devnull
    apt -y install apt-transport-https & devnull
    echo deb httpsartifacts.elastic.copackages7.xapt stable main  sudo tee -a etcaptsources.list.delastic-7.x.list & devnull
    apt update & devnull
fi
# Install Elasticsearch
echo [$(DATE)] [Info] [Elasticsearch] Installing Elasticsearch...
apt -y install elasticsearch=$VERSION & devnull
# Copy config, reload daemon and restart Elasticsearch
echo [$(DATE)] [Info] [Elasticsearch] Copy config, reload daemon and restart Elasticsearch...
cp -R $PROVISION_FOLDERelasticsearch etcelasticsearch & devnull
systemctl daemon-reload & devnull
systemctl enable elasticsearch  & devnull
service elasticsearch restart  & devnull
# Install Kibana
echo [$(DATE)] [Info] [Kibana] Installing Kibana...
apt -y install kibana=$VERSION & devnull
chown -R kibanakibana usrsharekibana
# Copy config, reload daemon and restart Kibana
echo [$(DATE)] [Info] [Kibana] Copy config, reload daemon and restart Kibana...
cp -R $PROVISION_FOLDERkibana etckibana & devnull
systemctl daemon-reload & devnull
systemctl enable kibana & devnull
service kibana restart & devnull
# Install Logstash
echo [$(DATE)] [Info] [Logstash] Installing Logstash...
apt -y install logstash=1$VERSION-1 & devnull
systemctl enable logstash & devnull
 
# Beats Family
# Install Filebeat
echo [$(DATE)] [Info] [Filebeat] Installing Filebeat...
apt -y install filebeat=$VERSION & devnull
# Install Packetbeat
echo [$(DATE)] [Info] [Packetbeat] Installing Packetbeat...
apt -y install libpcap0.8 & devnull
apt -y install packetbeat=$VERSION & devnull
# Install Metricbeat
echo [$(DATE)] [Info] [Metricbeat] Installing Metricbeat...
apt -y install metricbeat=$VERSION & devnull
# Install Heartbeat
echo [$(DATE)] [Info] [Heartbeat] Installing Heartbeat...
apt -y install heartbeat-elastic=$VERSION & devnull
# Install Auditbeat
echo [$(DATE)] [Info] [Auditbeat] Installing Auditbeat...
apt -y install auditbeat=$VERSION & devnull
# Install Elastic Agent
echo [$(DATE)] [Info] [Elastic Agent] Installing Elastic Agent...
apt -y install elastic-agent=$VERSION & devnull
# Tidying Up
# Clean unneeded packages
echo [$(DATE)] [Info] [System] Cleaning unneeded packages...
apt -y autoremove & devnull
# Update file search cache
echo [$(DATE)] [Info] [System] Updating file search cache...
updatedb & devnull
# Prevent package upgrade
echo [$(DATE)] [Info] [System] Prevent package upgrade...
apt-mark hold elasticsearch kibana logstash filebeat packetbeat metricbeat heartbeat-elastic auditbeat & devnull
# Clear Disk Cache
echo [$(DATE)] [Info] [System] Clear disk cache...
sync; echo 1  procsysvmdrop_caches
# Show IPs
echo [$(DATE)] [Info] [System] IP Address on the machine...
echo -e $IP
echo [$(DATE)] [Info] [System] Enjoy it! )