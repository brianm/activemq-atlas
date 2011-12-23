
download = "http://apache.osuosl.org//activemq/apache-activemq/5.5.1/apache-activemq-5.5.1-bin.tar.gz"

system "activemq" do

  server "shell", base: "server"
  
  server "broker", {
    cardinality: 3,
    base: "server",
    install: ["scratch:activemq-broker=@",
              "exec:sudo service activemq stop",
              "exec:sudo mkdir -p /opt/activemq/",
              "tgz:#{download}?to=/opt/activemq/&skiproot=apache-activemq-5.5.1",
              "erb:activemq.xml.erb > /opt/activemq/conf/activemq.xml",
              "exec:sudo ln -s /opt/activemq/bin/activemq /etc/init.d/",
              "exec:sudo update-rc.d activemq defaults",
              "exec:sudo update-rc.d activemq enable",
              "exec:sudo service activemq start"]
  }
end

