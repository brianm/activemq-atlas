
natty_useast_i386_ebs = "ami-e358958a"

environment "ec2" do

  listener "progress-bars"

  listener "aws-config", {
    ssh_ubuntu: "ubuntu@default",
  }

  system "security" do
    service "activemq-group", base: "sec-group:activemq"
  end

  base "sec-group", {
    provisioner: ["ec2-security-group:{base.fragment}", {
                    ssh_from_anywhere: "tcp 22 0.0.0.0/0",
                    openwire:          "tcp 61616 activemq",
                    something_else:    "tcp 56710 activemq",
                    java_crap:         "tcp 8161 activemq",
                    java_crap_2:       "tcp 1099 activemq",
                  }]
  }

  base "server", {
    provisioner: ["ec2:#{natty_useast_i386_ebs}", {
      instance_type: "m1.small",
      security_group: "activemq"
    }],
    init: ["exec:sudo apt-get update", "apt:openjdk-6-jdk"]
  }
end
