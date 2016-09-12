#!/usr/bin/env bash

set -x

yum update -y
yum install -y openssl-devel readline ncurses gcc net-tools wget curl lsof

cd /usr/src
wget http://www.softether-download.com/files/softether/v4.21-9613-beta-2016.04.24-tree/Linux/SoftEther_VPN_Server/64bit_-_Intel_x64_or_AMD64/softether-vpnserver-v4.21-9613-beta-2016.04.24-linux-x64-64bit.tar.gz
tar xzvf softether-vpnserver-v4.21-9613-beta-2016.04.24-linux-x64-64bit.tar.gz
cd vpnserver/

# Compile
echo -e "1\n1\n1\n" | make -

# Install
cd ..
mv vpnserver /usr/local/

ls -l /usr/local/vpnserver/
cd /usr/local/vpnserver/

chmod 600 *
chmod 700 vpnserver
chmod 700 vpncmd

cat << EOF > /etc/init.d/vpnserver
#!/bin/sh
# chkconfig: 2345 99 01
# description: SoftEther VPN Server
DAEMON=/usr/local/vpnserver/vpnserver
LOCK=/var/lock/subsys/vpnserver
test -x $DAEMON || exit 0
case "$1" in
start)
$DAEMON start
touch $LOCK
;;
stop)
$DAEMON stop
rm $LOCK
;;
restart)
$DAEMON stop
sleep 3
$DAEMON start
;;
*)
echo "Usage: $0 {start|stop|restart}"
exit 1
esac
exit 0
EOF

mkdir /var/lock/subsys
chmod 755 /etc/init.d/vpnserver
chkconfig --add vpnserver
