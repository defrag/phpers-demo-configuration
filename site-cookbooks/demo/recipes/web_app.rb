include_recipe "apache2"
include_recipe "apache2::mod_rewrite"
include_recipe "apache2::mod_php5"

web_app "sf2_demo_app" do
  server_name 'sf2_demo'
  docroot "/var/www/sf_demo/current/web"
end

if not Chef::Config[:solo]
  directory "/var/www" do
    owner "ubuntu"
    group "www-data"
    recursive true
  end
end