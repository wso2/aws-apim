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

# Claas apim::params
# This class includes all the necessary parameters.
class apim::params inherits apim_common::params {

  $start_script_template = 'bin/api-manager.sh'
  $jvmxms = '256m'
  $jvmxmx = '1024m'

  $template_list = [
    'repository/conf/deployment.toml'
  ]

  # Define file list
  $file_list = []

  # Define remove file list
  $file_removelist = []

  # ----- Carbon.xml config params -----
  /*
     Host name or IP address of the machine hosting this server
     e.g. www.wso2.org, 192.168.1.10
     This is will become part of the End Point Reference of the
     services deployed on this server instance.
  */
  $hostname = 'CF_ELB_DNS_NAME'

  # ----- api-manager.xml config params -----
  $oauth_configs_revoke_api_url = 'https://localhost:${https.nio.port}/revoke'
  $throttle_config_policy_deployer_url = 'https://localhost:${mgt.transport.https.port}${carbon.context}services/'
}
