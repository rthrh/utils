# Stop existing OVS processes. kill -9 works too.
/usr/local/share/openvswitch/scripts/ovs-ctl stop
sleep 1
cd /home/brent/openvswitch
rm  /usr/local/etc/openvswitch/conf.db
/usr/local/bin/ovsdb-tool create /usr/local/etc/openvswitch/conf.db vswitchd/vswitch.ovsschema
 
 ovsdb-server --remote=punix:/usr/local/var/run/openvswitch/db.sock  \
  --remote=db:Open_vSwitch,Open_vSwitch,manager_options \
  --private-key=db:Open_vSwitch,SSL,private_key  \
  --certificate=db:Open_vSwitch,SSL,certificate     \
  --bootstrap-ca-cert=db:Open_vSwitch,SSL,ca_cert  \
  --log-file=/var/log/openvswitch/ovs-vswitchd.log \
  -vsyslog:dbg -vfile:dbg  --pidfile --detach
ovs-vswitchd -v --pidfile --detach \
 --log-file=/var/log/openvswitch/ovs-vswitchd.log \
  -vconsole:err -vsyslog:info -vfile:info
ovs-vsctl --no-wait init
sudo ovs-vsctl set-manager ptcp:6640

echo "ovs-db reset"
