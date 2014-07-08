include_recipe 'jenkins::master'

jenkins_plugin 'git'
jenkins_plugin 'build-token-root'

package 'ant' do 
  action :install
end

include_recipe 'python'
python_pip 'fabric'
python_pip 'pychef'