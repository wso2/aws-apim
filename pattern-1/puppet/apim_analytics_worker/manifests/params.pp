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
class apim_analytics_worker::params {
  $user = 'wso2carbon'
  $user_id = 802
  $user_group = 'wso2'
  $user_home = '/home/$user'
  $user_group_id = 802
  $product = 'wso2am-analytics'
  $profile = 'worker'
  $service_name = "${product}-${profile}"
  $hostname = 'localhost'
  $mgt_hostname = 'localhost'
  $jdk_version = 'jdk1.8.0_192'
  $am_package = 'wso2am-analytics-3.0.0.zip'
  $db_managment_system = 'CF_DBMS'
  $oracle_sid = 'WSO2AMDB'
  $db_password = 'CF_DB_PASSWORD'

  # Define the template
  $start_script_template = "bin/${profile}.sh"
  $template_list = [
    'conf/worker/deployment.yaml',
  ]

  # -------------- Deploymeny.yaml Config -------------- #

  # Carbon Configuration Parameters
  $ports_offset = 1

  # transport.http config
  $private_ip = $::ipaddress
  $msf4j_listener_keystore = '${carbon.home}/resources/security/wso2carbon.jks'
  $msf4j_listener_keystore_password = 'wso2carbon'
  $msf4j_listener_keystore_cert_pass = 'wso2carbon'

  # siddhi.stores.query.api config
  $siddhi_default_listener_host = '0.0.0.0'
  $siddhi_msf4j_host = '0.0.0.0'
  $siddhi_msf4j_listener_keystore = '${carbon.home}/resources/security/wso2carbon.jks'
  $siddhi_msf4j_listener_keystore_password = 'wso2carbon'
  $siddhi_msf4j_listener_keystore_cert_pass = 'wso2carbon'

  # Configuration used for the databridge communication
  $databridge_keystore = '${sys:carbon.home}/resources/security/wso2carbon.jks'
  $databridge_keystore_password = 'wso2carbon'
  $binary_data_receiver_hostname = 'ANALYTICS_IP'

  # Configuration of the Data Agents - to publish events through
  $thrift_agent_trust_store = '${sys:carbon.home}/resources/security/client-truststore.jks'
  $thrift_agent_trust_store_password = 'wso2carbon'
  $binary_agent_trust_store = '${sys:carbon.home}/resources/security/client-truststore.jks'
  $binary_agent_trust_store_password = 'wso2carbon'

  # Secure Vault Configuration
  $securevault_key_store = '${sys:carbon.home}/resources/security/securevault.jks'
  $securevault_private_key_alias = 'wso2carbon'
  $securevault_secret_properties_file = '${sys:carbon.home}/conf/${sys:wso2.runtime}/secrets.properties'
  $securevault_master_key_reader_file = '${sys:carbon.home}/conf/${sys:wso2.runtime}/master-keys.yaml'

  # Data Sources Configuration
  $metrics_db_url = 'jdbc:h2:${sys:carbon.home}/wso2/dashboard/database/metrics;AUTO_SERVER=TRUE'
  $metrics_db_username = 'wso2carbon'
  $metrics_db_password = 'wso2carbon'
  $metrics_db_driver = 'org.h2.Driver'

  $permission_db_url = 'jdbc:h2:${sys:carbon.home}/wso2/${sys:wso2.runtime}/database/PERMISSION_DB;IFEXISTS=TRUE;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000;MVCC=TRUE'
  $permission_db_username = 'wso2carbon'
  $permission_db_password = 'wso2carbon'
  $permission_db_driver = 'org.h2.Driver'

  $message_tracing_db_url = 'jdbc:h2:${sys:carbon.home}/wso2/dashboard/database/MESSAGE_TRACING_DB;AUTO_SERVER=TRUE'
  $message_tracing_db_username = 'wso2carbon'
  $message_tracing_db_password = 'wso2carbon'
  $message_tracing_db_driver = 'org.h2.Driver'

  if $db_managment_system == 'mysql' {
    $db_type = 'mysql'
    $stat_db_username = 'CF_DB_USERNAME'
    $wso2_stat_db_url = 'jdbc:mysql://CF_RDS_URL:3306/WSO2AM_STAT_DB?autoReconnect=true&amp;useSSL=false'
    $db_driver_class_name = 'com.mysql.jdbc.Driver'
    $db_connector = 'mysql-connector-java-5.1.41-bin.jar'
    $db_validation_query = 'SELECT 1'
  } elsif $db_managment_system =~ 'oracle' {
    $db_type = 'oracle'
    $stat_db_username = 'WSO2AM_APIMGT_DB'
    $wso2_stat_db_url = "jdbc:oracle:thin:@CF_RDS_URL:1521/${oracle_sid}"
    $wso2_am_db_url = "jdbc:oracle:thin:@CF_RDS_URL:1521/${oracle_sid}"
    $db_driver_class_name = 'oracle.jdbc.OracleDriver'
    $db_validation_query = 'SELECT 1 FROM DUAL'
    $db_connector = 'ojdbc8_1.0.0.jar'
  } elsif $db_managment_system == 'sqlserver-se' {
    $db_type = 'mssql'
    $stat_db_username = 'CF_DB_USERNAME'
    $wso2_stat_db_url = 'jdbc:sqlserver://CF_RDS_URL:1433;databaseName=WSO2AM_STAT_DB;SendStringParametersAsUnicode=false'
    $db_driver_class_name = 'com.microsoft.sqlserver.jdbc.SQLServerDriver'
    $db_connector = 'mssql-jdbc-7.0.0.jre8.jar'
    $db_validation_query = 'SELECT 1'
  } elsif $db_managment_system == 'postgres' {
    $db_type = 'postgre'
    $stat_db_username = 'CF_DB_USERNAME'
    $wso2_stat_db_url = 'jdbc:postgresql://CF_RDS_URL:5432/WSO2AM_STAT_DB'
    $db_driver_class_name = 'org.postgresql.Driver'
    $db_connector = 'postgresql-42.2.5.jar'
    $db_validation_query = 'SELECT 1; COMMIT'
  }

  $wso2_stat_db = {
    type              => $db_type,
    url               => $wso2_stat_db_url,
    username          => $stat_db_username,
    password          => $db_password,
    driver_class_name => $db_driver_class_name,
    validation_query  => $db_validation_query,
  }
}
