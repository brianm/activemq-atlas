This is a set of [Atlas](http://github.com/ning/atlas) configs to
bring up a network of [Apache ActiveMQ](http://activemq.apache.org)
brokers.

To use it, first build download
[atlas](https://atlas-resources.s3.amazonaws.com/atlas) and set make
it executable (<code>chmod +x ./atlas</code>). The binary requires
Java 1.6, so have Java installed, put that executable on your path and
<code>cd</code> into your checkout of this project.

    $ atlas -e ./env-ec2.rb -s sys-activemq.rb init
    $ atlas update
    
It should ask you for your EC2 access credentials (oh yeah, you need
those). Then it will take a while as it spins up EC2 instances,
installs, and wires things up. Once it finishes, you can see what is
there and ssh into instances:

    $ atlas ls
    $ atlas ssh shell
    
The shell host has a small ruby script at <code>~/smoke_test.rb</code>
that connects to different brokers in the network and sends a
message. Run it via
    
    $ ./smoke_test.rb
    
And you should get a message telling you that it works. Play around
with it and have fun!

Notes:

* ActiveMQ is installed under <code>/opt/activemq</code>
* The brokers are listening for OpenWire on port 61616, Stomp on
  61612, and Stomp+NIO on 61613
* The best way to restart a broker is <code>sudo service activemq restart</code>
* The progress bars get confused sometimes, sorry.
