# -*- mode: ruby -*-
# vi: set ft=ruby ts=2 sw=2 et sts=2:

memory_size = 4096
number_cpus = 1

box = "puppetlabs/centos-7.2-64-nocm"
repo = "http://bigtop-repos.s3.amazonaws.com/releases/1.2.0/centos/7/x86_64"
components = ["hdfs", "yarn", "mapreduce", "hive"]
hostname = "local-dev"
fqdn = "#{hostname}.vagrant"
master_node = fqdn
ip = "10.13.55.101"

$script = <<SCRIPT
service iptables stop
service firewalld stop
chkconfig iptables off
# Remove 127.0.0.1 entry since vagrant's hostname setting will map it to FQDN,
# which miss leads some daemons to bind on 127.0.0.1 instead of public or private IP
sed -i "/127.0.0.1/d" /etc/hosts
echo "Bigtop yum repo = #{repo}"
# Prepare host manipulation files needed in standalone box
cp /vagrant/config_hosts /etc/init.d
cp /vagrant/gen_hosts.sh /usr/bin
chkconfig --add config_hosts
# Prepare puppet configuration file
cat > /etc/puppet/hieradata/site.yaml << EOF
bigtop::hadoop_head_node: #{master_node}
hadoop::hadoop_storage_dirs: [/data/1, /data/2]
bigtop::bigtop_repo_uri: #{repo}
hadoop_cluster_node::cluster_components: #{components}
hadoop::common_hdfs::testonly_hdfs_sshkeys: "yes"
EOF
SCRIPT

Vagrant.configure("2") do |config|

  config.hostmanager.enabled = true
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

  config.vm.box = box
  config.vm.provider :virtualbox do |vb|
    vb.name = hostname
	  vb.customize ["modifyvm", :id, "--memory", memory_size]
    vb.customize ['modifyvm', :id, '--cpus', number_cpus]
  end

  config.vm.network :private_network, ip: ip
  config.vm.hostname = fqdn

  config.vm.synced_folder "./", "/vagrant"

  config.vm.provision "shell", path: "./setup-env-centos.sh"
  config.vm.provision "shell", path: "./prepare-bigtop.sh"
  config.vm.provision "shell", inline: $script
  config.vm.provision "shell", path: "./deploy-bigtop.sh"
  config.vm.provision "shell", path: "./deploy-mariadb.sh"
  config.vm.provision "shell", path: "./deploy-azkaban.sh"

  config.hostmanager.aliases = "#{fqdn} #{hostname}"
end
