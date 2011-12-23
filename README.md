This is a set of [Atlas](http://github.com/ning/atlas) configs to
bring up a network of [Apache ActiveMQ](http://activemq.apache.org)
brokers.

To use it, first build download
[the atlas binary](https://atlas-resources.s3.amazonaws.com/atlas) (or
[check it out and build it](http://github.com/ning/atlas)) and
set make it executable (<code>chmod +x ./atlas</code>). The binary
requires Java 1.6, so have Java installed, put that executable on your
path and <code>cd</code> into your checkout of this project.

    $ atlas -e ./env-ec2.rb -s sys-activemq.rb init
    $ atlas update
    
It should ask you for your EC2 access credentials (get them
[here](https://aws-portal.amazon.com/gp/aws/developer/account/index.html?action=access-key)). Then
it will take a while as it spins up EC2 instances, installs, and wires
things up. Once it finishes, you can see what is there and ssh into
instances:

    $ atlas ls
    $ atlas ssh shell
    
The shell host has a small ruby script at <code>~/smoke_test.rb</code>
that connects to different brokers in the network and sends a
message. Run it via
    
    $ ./smoke_test.rb
    
And you should get a message telling you that it works. Play around
with it and have fun!

When you are finished playing, you can tear down the servers that were
set up with:

    $ atlas destroy
    
When you want to play again you can go in and start them via
<code>atlas update</code> again. Do the work from the same directory
as it stores state (like your AWS access credentials)
<code>.atlas/</code>.

Notes:

* ActiveMQ is installed under <code>/opt/activemq</code>
* The brokers are listening for OpenWire on port 61616, Stomp on
  61612, and Stomp+NIO on 61613
* The best way to restart a broker is <code>sudo service activemq restart</code>
* The progress bars get confused sometimes, sorry.
