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

# Class apim_analytics_dashboard::params
# This class includes all the necessary parameters.
class apim_analytics_dashboard::params inherits apim_common::params {

  # Define the template
  $start_script_template = "bin/dashboard.sh"

  # Define the template
  $template_list = [
    'conf/dashboard/deployment.yaml'
  ]

  # Define file list
  $file_list = []

  # Define remove file list
  $file_removelist = []

  # -------------- Deployment.yaml Config -------------- #

  # Carbon Configuration Parameters
  $ports_offset = 3

  $wso2_carbon_id = 'wso2-am-analytics'

  $thrift_data_receiver_tcp_port = 7611
  $thrift_data_receiver_ssl_port = 7711

  $transport_listner_config_port_default = 9089
  $transport_listner_config_port = 9643

  # Configuration used for the databridge communication
  $binary_data_receiver_tcp_port = 9611
  $binary_data_receiver_ssl_port = 9711

  # Data Sources Configuration
  $business_rules_db_url = 'jdbc:h2:${sys:carbon.home}/wso2/${sys:wso2.runtime}/database/BUSINESS_RULES_DB;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000;MVCC=TRUE'
  $business_rules_db_username = 'wso2carbon'
  $business_rules_db_password = 'wso2carbon'
  $business_rules_db_driver = 'org.h2.Driver'
  $business_rules_db_test_query = 'SELECT 1'

  $status_dashboard_db_url = 'jdbc:h2:${sys:carbon.home}/wso2/${sys:wso2.runtime}/database/wso2_status_dashboard;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000;MVCC=TRUE'
  $status_dashboard_db_username = 'wso2carbon'
  $status_dashboard_db_password = 'wso2carbon'
  $status_dashboard_db_driver = 'org.h2.Driver'

  # wso2.business.rules.manager config
  $business_rules_manager_username = 'admin'
  $business_rules_manager_password = 'admin'

  # transport.http configuration
  $default_host = '0.0.0.0'
  $default_listener_keystore_cert_pass = 'wso2carbon'

  # dashboard admin service configurations
  $admin_service_url = 'https://localhost:9443'
  $admin_service_username = 'admin'
  $admin_service_password = 'admin'
  $keymanager_username = 'admin'
  $keymanager_password = 'admin'

  # worker configurations
  # ip: ip of the worker node
  # port: wso2_transport_msf4j_https_port of the worker node given under host_vars
  $worker_nodes = [
    {
      ip => 'localhost',
      port => '9444'
    }
  ]
}
