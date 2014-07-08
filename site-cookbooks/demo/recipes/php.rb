include_recipe "git"
include_recipe "apt"
#include_recipe "build-essential"

apt_repository "php54" do
  uri "http://ppa.launchpad.net/ondrej/php5-oldstable/ubuntu"
  distribution node['lsb']['codename']
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "E5267A6C"
end

include_recipe 'php'
include_recipe 'php::module_apc'
include_recipe 'php::module_curl'
include_recipe 'php::module_gd'

package "php5-intl" do
  action :install
end

package "php5-mysql" do
  action :install
end

package "php5-xsl" do
  action :install
end

%w{acl augeas-tools}.each do |pkg|
  package pkg
end

execute "update_fstab" do
  command <<-EOF
      echo 'ins opt after /files/etc/fstab/*[file="/"]/opt[last()]
      set /files/etc/fstab/*[file="/"]/opt[last()] acl
      save' | augtool
      mount -o remount /
  EOF
  not_if "augtool match '/files/etc/fstab/*[file=\"/\" and count(opt[.=\"acl\"])=0]'"
end