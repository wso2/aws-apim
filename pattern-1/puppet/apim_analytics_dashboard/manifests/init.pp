# ----------------------------------------------------------------------------
#  Copyright (c) 2018 WSO2, Inc. http://www.wso2.org
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
# ----------------------------------------------------------------------------

# Class: apim_analytics_dashboard
# Init class of API Manager Analytics - Worker profile
class apim_analytics_dashboard inherits apim_analytics_dashboard::params {

  # Create wso2 group
  group { $user_group:
    ensure => present,
    gid    => $user_group_id,
    system => true,
  }

  # Create wso2 user
  user { $user:
    ensure => present,
    uid    => $user_id,
    gid    => $user_group_id,
    home   => "/home/${user}",
    system => true,
  }
  # Ensure the installation directory is available
  file { "/opt/${product}":
    ensure => 'directory',
    owner  => $user,
    group  => $user_group,
  }

  file { "/usr/lib/wso2/":
    ensure => directory,
    owner  => $user,
    group  => $user_group,
  }

  file { "/usr/lib/wso2/wso2am-analytics/":
    ensure => directory,
    owner  => $user,
    group  => $user_group,
  }

  file { "/usr/lib/wso2/wso2am-analytics/3.0.0/":
    ensure => directory,
    owner  => $user,
    group  => $user_group,
  }

  # Copy the relevant installer to the /opt/is directory
  file { "/usr/lib/wso2/wso2am-analytics/3.0.0/${am_package}":
    owner  => $user,
    group  => $user_group,
    mode   => '0644',
    source => "puppet:///modules/installers/${am_package}",
  }

  # Install WSO2 Identity Server
  exec { 'unzip':
    command => 'unzip wso2am-analytics-3.0.0.zip',
    cwd     => '/usr/lib/wso2/wso2am-analytics/3.0.0/',
    path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
  }

  #jdk
  file { "/usr/lib/wso2/wso2am-analytics/3.0.0/jdk-8u192-ea-bin-b02-linux-x64-19_jul_2018.tar.gz":
    owner  => $user,
    group  => $user_group,
    mode   => '0644',
    source => "puppet:///modules/installers/jdk-8u192-ea-bin-b02-linux-x64-19_jul_2018.tar.gz",
  }

  # Install WSO2 Identity Server
  exec { 'tar':
    command => 'tar -xvf jdk-8u192-ea-bin-b02-linux-x64-19_jul_2018.tar.gz',
    cwd     => '/usr/lib/wso2/wso2am-analytics/3.0.0/',
    path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
  }

  # Copy configuration changes to the installed directory
  $template_list.each | String $template | {
    file { "/usr/lib/wso2/wso2am-analytics/3.0.0/wso2am-analytics-3.0.0/${template}":
      ensure  => file,
      owner   => $user,
      group   => $user_group,
      mode    => '0644',
      content => template("${module_name}/carbon-home/${template}.erb")
    }
  }

  # Copy wso2server.sh to installed directory
  file { "/usr/lib/wso2/wso2am-analytics/3.0.0/wso2am-analytics-3.0.0/${start_script_template}":
    ensure  => file,
    owner   => $user,
    group   => $user_group,
    mode    => '0754',
    content => template("${module_name}/carbon-home/${start_script_template}.erb")
  }

  file { "/usr/lib/wso2/wso2am-analytics/3.0.0/wso2am-analytics-3.0.0/${carbon_start_script}":
    ensure  => file,
    owner   => $user,
    group   => $user_group,
    mode    => '0754',
    content => template("${module_name}/carbon-home/${carbon_start_script}.erb")
  }

  # Copy mysql connector to the installed directory
  file { "/usr/lib/wso2/wso2am-analytics/3.0.0/wso2am-analytics-3.0.0/lib/mysql-connector-java-5.1.41-bin.jar":
    owner  => $user,
    group  => $user_group,
    mode   => '0754',
    source => "puppet:///modules/installers/mysql-connector-java-5.1.41-bin.jar",
  }

  file { "/usr/lib/wso2/wso2am-analytics/3.0.0/wso2am-analytics-3.0.0/wso2/lib/plugins/org.wso2.analytics.apim.rest.api.proxy_3.0.0.jar":
    owner  => $user,
    group  => $user_group,
    mode   => '0754',
    source => "puppet:///modules/installers/org.wso2.analytics.apim.rest.api.proxy_3.0.0.jar",
  }

  file { "/usr/local/bin/private_ip_extractor.py":
    owner  => $user,
    group  => $user_group,
    mode   => '0754',
    source => "puppet:///modules/installers/private_ip_extractor.py",
  }

  # Copy the unit file required to deploy the server as a service
  file { "/etc/systemd/system/${service_name}.service":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0754',
    content => template("${module_name}/${service_name}.service.erb"),
  }

  /*
    Following script can be used to copy file to a given location.
    This will copy some_file to install_path -> repository.
    Note: Ensure that file is available in modules -> apim -> files
  */
  # file { "${install_path}/repository/some_file":
  #   owner  => $user,
  #   group  => $user_group,
  #   mode   => '0644',
  #   source => "puppet:///modules/${module_name}/some_file",
  # }
}

