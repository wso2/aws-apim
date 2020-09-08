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

# Claas apim_analytics_worker::params
# This class includes all the necessary parameters.
class apim_analytics_worker::params inherits apim_common::params {

  # Define the template
  $start_script_template = "bin/worker.sh"

  # Define the template
  $template_list = [
    'conf/worker/deployment.yaml'
  ]

  # Define file list
  $file_list = []

  # Define remove file list
  $file_removelist = []

  # -------------- Deployment.yaml Config -------------- #

  # Carbon Configuration Parameters
  $wso2_carbon_id = 'wso2-am-analytics'
  $ports_offset = 1

  # Configuration used for the databridge communication
  $binary_data_receiver_tcp_pool_side = 100
  $binary_data_receiver_ssl_pool_side = 100

  $state_persistence_enabled = 'false'
  $state_persistence_interval = 1
  $state_persistence_revisions = 2

  # transport.http config
  $hostname = '0.0.0.0'
  $wso2_transport_default_port = 9091
  $wso2_transport_msf4j_https_port = 9444

  # siddhi.stores.query.api config
  $siddhi_api_default_port = 7071
  $siddhi_api_msf4j_https_port = 7444
  $siddhi_api_keystore_file = '${carbon.home}/resources/security/wso2carbon.jks'
  $siddhi_api_keystore_password = 'wso2carbon'
  $siddhi_api_keystore_cert_password = 'wso2carbon'

  $thrift_data_receiver_tcp_port = 7611
  $thrift_data_receiver_ssl_port = 7711

  $binary_data_receiver_tcp_port = 9611
  $bianry_data_receiver_ssl_port = 9711

  # Data Sources Configurations
  $message_tracing_db_url = 'jdbc:h2:${sys:carbon.home}/wso2/dashboard/database/MESSAGE_TRACING_DB;AUTO_SERVER=TRUE'
  $message_tracing_db_username = 'wso2carbon'
  $message_tracing_db_password = 'wso2carbon'
  $message_tracing_db_driver = 'org.h2.Driver'
  $message_tracing_db_test_query = 'SELECT 1'

  $persistence_db_url = 'jdbc:h2:${sys:carbon.home}/wso2/${sys:wso2.runtime}/database/PERSISTENCE_DB;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000;AUTO_SERVER=TRUE'
  $persistence_db_username = 'root'
  $persistence_db_password = 'pass
  $persistence_db_driver = 'com.mysql.jdbc.Driver'
  $persistence_db_test_query = 'SELECT 1'

  $cluster_db_url = 'jdbc:h2:${sys:carbon.home}/wso2/${sys:wso2.runtime}/database/WSO2_CLUSTER_DB;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000;AUTO_SERVER=TRUE'
  $cluster_db_username = 'wso2carbon'
  $cluster_db_password = 'wso2carbon'
  $cluster_db_driver = 'com.mysql.jdbc.Driver'
  $cluster_db_test_query = 'SELECT 1'

  # Cluster configurations
  $cluster_config_enabled = 'false'
  $cluster_config_group_id = 'sp'
  $cluster_config_heartbeat_interval = 1000
  $cluster_config_max_retry = 2
  $cluster_config_event_polling_interval = 1000

  $authentication_type = 'local'
  $authentication_admin_role = 'admin'
  $user_store_users = [
    {
      username  =>  'admin',
      password  =>  'YWRtaW4=',
      roles     =>  1
    }
  ]
  $user_store_roles = [
    {
      displayName  =>  'admin',
      id     =>  1
    }
  ]

  # Configurations for High Availability deployments
  # $deployment_type = 'ha'
  # $eventSyncServer_host = 'localhost'
  # $eventSyncServer_port = '9893'
  # $eventSyncServer_advertised_host = 'localhost'
  # $eventSyncServer_advertised_port = '9893'

  # Configurations for distributed deployments
  # $deployment_type = 'distributed'
  # $https_interface_host = '192.168.1.3'
  # $https_interface_port = '9443'
  # $https_interface_username = 'admin'
  # $https_interface_password = 'admin'
  # $resource_managers = [
  #   {
  #     host     => '192.168.1.3',
  #     port     => '9443',
  #     username => 'admin',
  #     password => 'admin'
  #   },
  #   {
  #     host     => '192.168.1.1',
  #     port     => '9443',
  #     username => 'admin',
  #     password => 'admin'
  #   }
  # ]
}
