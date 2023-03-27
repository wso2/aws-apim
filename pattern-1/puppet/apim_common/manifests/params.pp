#----------------------------------------------------------------------------
#  Copyright (c) 2019 WSO2, Inc. http://www.wso2.org
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
#----------------------------------------------------------------------------

class apim_common::params {

  $packages = ["unzip"]
  $version = "4.2.0"

  # Set the location the product packages should reside in (eg: "local" in the /files directory, "remote" in a remote location)
  $pack_location = "local"
  # $pack_location = "remote"
  # $remote_jdk = "<URL_TO_JDK_FILE>"

  $user = 'wso2carbon'
  $user_group = 'wso2'
  $user_id = 802
  $user_group_id = 802

  # WSO2 TestGrid specific parameters
  $enable_test_mode = 'ENABLE_TEST_MODE'
  $jdk_version = 'JDK_TYPE'
  $db_managment_system = 'CF_DBMS'
  $oracle_sid = 'WSO2AMDB'
  $db_password = 'CF_DB_PASSWORD'
  $aws_access_key = 'access-key'
  $aws_secret_key = 'secretkey'
  $aws_region = 'REGION_NAME'
  $local_member_host = $::ipaddress

  # Performance tuning configurations
  $enable_performance_tuning = false
  $performance_tuning_flie_list = [
    'etc/sysctl.conf',
    'etc/security/limits.conf',
  ]

  # JDK Distributions
  # WSO2 TestGrid specific configuration Params
  if $jdk_version == 'CORRETTO_JDK11' {
    $jdk_file_name = "amazon-corretto-11.0.18.10.1-linux-x64.tar.gz"
    $jdk_name = "amazon-corretto-11.0.18.10.1-linux-x64"
  } elsif $jdk_version == 'TEMURIN_JDK11' {
    $jdk_file_name = "OpenJDK11U-jdk_x64_linux_hotspot_11.0.18_10.tar.gz"
    $jdk_name = "jdk-11.0.18_10"
  } elsif $jdk_version == 'CORRETTO_JDK17' {
    $jdk_file_name = "amazon-corretto-17.0.6.10.1-linux-x64.tar.gz"
    $jdk_name = "amazon-corretto-17.0.6.10.1-linux-x64"
  } elsif $jdk_version == 'TEMURIN_JDK17' {
    $jdk_file_name = "OpenJDK17U-jdk_x64_linux_hotspot_17.0.6_10.tar.gz"
    $jdk_name = "jdk-17.0.6_10"
  }

  $java_dir = "/opt"
  $java_symlink = "${java_dir}/java"
  $java_home = "${java_dir}/${jdk_name}"

  $profile = $profile
  $target = "/usr/lib/wso2"
  $product_dir = "${target}/wso2am/${version}"
  $pack_dir = "${target}/packs"
  $wso2_service_name = "wso2${profile}"
  $installation_dirs = [ "${target}", "${target}/wso2am", "${target}/wso2am/${version}", "${pack_dir}", ]

  # ----- Profile configs -----
  case $profile {
    'mi': {
      $pack = "wso2mi-${version}"
      # $remote_pack = "<URL_TO_MI400_PACK>"
      $server_script_path = "${product_dir}/${pack}/bin/micro-integrator.sh"
      $pid_file_path = "${product_dir}/${pack}/wso2carbon.pid"
    }
    default: {
      $pack = "wso2am-${version}"
      # $remote_pack = "<URL_TO_APIM_PACK>"
      $server_script_path = "${product_dir}/${pack}/bin/api-manager.sh"
      $pid_file_path = "${product_dir}/${pack}/wso2carbon.pid"
      $optimize_params = ""
    }
  }

  # Pack Directories
  $carbon_home = "${product_dir}/${pack}"
  $product_binary = "${pack}.zip"

  # Server stop retry configs
  $try_count = 5
  $try_sleep = 5

  # ----- api-manager.xml config params -----
  $analytics_enabled = 'false'
  $analytics_config_endpoint = 'https://localhost:8080/auth/v1'
  $analytics_auth_token = ''  

  $throttle_decision_endpoints = '"tcp://tm1.local:5672","tcp://tm2.local:5672"'
  $throttling_url_group = [
    {
      traffic_manager_urls      => '"tcp://tm1.local:9611"',
      traffic_manager_auth_urls => '"ssl://tm1.local:9711"'
    },
    {
      traffic_manager_urls      => '"tcp://tm2.local:9611"',
      traffic_manager_auth_urls => '"ssl://tm2.local:9711"'
    }
  ]

  $gateway_environments = [
    {
      type                                    => 'hybrid',
      name                                    => 'Default',
      provider                                => 'wso2',
      description                             => 'This is a hybrid gateway that handles both production and sandbox token traffic.',
      server_url                              => 'https://localhost:${mgt.transport.https.port}/services/',
      ws_endpoint                             => 'ws://CF_ELB_DNS_NAME:9099',
      wss_endpoint                            => 'wss://CF_ELB_DNS_NAME:8099',
      http_endpoint                           => 'http://CF_ELB_DNS_NAME:${http.nio.port}',
      https_endpoint                          => 'https://CF_ELB_DNS_NAME:${https.nio.port}',
      websub_event_receiver_http_endpoint     => 'http://CF_ELB_DNS_NAME:9021',
      websub_event_receiver_https_endpoint    => 'https://CF_ELB_DNS_NAME:8021'
    }
  ]

  $key_manager_server_url = 'https://CF_ELB_DNS_NAME:${mgt.transport.https.port}/services/'
  $key_validator_thrift_server_host = 'CF_ELB_DNS_NAME'

  $api_devportal_url = 'https://CF_ELB_DNS_NAME:${mgt.transport.https.port}/devportal'
  $api_devportal_server_url = 'https://CF_ELB_DNS_NAME:${mgt.transport.https.port}/services/'

  $traffic_manager_receiver_url = 'tcp://${carbon.local.ip}:${receiver.url.port}'
  $traffic_manager_auth_url = 'ssl://${carbon.local.ip}:${auth.url.port}'

  # ----- Master-datasources config params -----

  if $db_managment_system == 'mysql' {
    $db_type = 'mysql'
    $reg_db_user_name = 'CF_DB_USERNAME'
    $um_db_user_name = 'CF_DB_USERNAME'
    $am_db_user_name = 'CF_DB_USERNAME'
    $wso2_reg_db_url = 'jdbc:mysql://CF_RDS_URL:3306/WSO2AM_COMMON_DB?autoReconnect=true&amp;useSSL=false'
    $wso2_um_db_url = 'jdbc:mysql://CF_RDS_URL:3306/WSO2AM_COMMON_DB?autoReconnect=true&amp;useSSL=false'
    $wso2_am_db_url = 'jdbc:mysql://CF_RDS_URL:3306/WSO2AM_APIMGT_DB?autoReconnect=true&amp;useSSL=false'
    $am_db_url = 'jdbc:mysql://CF_RDS_URL:3306/AM_DB?autoReconnect=true&amp;useSSL=false'
    $db_driver_class_name = 'com.mysql.jdbc.Driver'
    $db_connector = 'mysql-connector-java-5.1.48-bin.jar'
    $db_validation_query = 'SELECT 1'
  } elsif $db_managment_system =~ 'oracle' {
    $db_type = 'oracle'
    $reg_db_user_name = 'WSO2AM_COMMON_DB'
    $um_db_user_name = 'WSO2AM_COMMON_DB'
    $am_db_user_name = 'WSO2AM_APIMGT_DB'
    $wso2_reg_db_url = "jdbc:oracle:thin:@CF_RDS_URL:1521/${oracle_sid}"
    $wso2_um_db_url = "jdbc:oracle:thin:@CF_RDS_URL:1521/${oracle_sid}"
    $wso2_am_db_url = "jdbc:oracle:thin:@CF_RDS_URL:1521/${oracle_sid}"
    $am_db_url = "jdbc:oracle:thin:@CF_RDS_URL:1521/${oracle_sid}"
    $db_driver_class_name = 'oracle.jdbc.OracleDriver'
    $db_validation_query = 'SELECT 1 FROM DUAL'
    $db_connector = 'ojdbc8.jar'
  } elsif $db_managment_system == 'sqlserver-se' {
    $db_type = 'mssql'
    $reg_db_user_name = 'CF_DB_USERNAME'
    $um_db_user_name = 'CF_DB_USERNAME'
    $am_db_user_name = 'CF_DB_USERNAME'
    $wso2_reg_db_url = 'jdbc:sqlserver://CF_RDS_URL:1433;databaseName=WSO2AM_COMMON_DB;SendStringParametersAsUnicode=false'
    $wso2_um_db_url = 'jdbc:sqlserver://CF_RDS_URL:1433;databaseName=WSO2AM_COMMON_DB;SendStringParametersAsUnicode=false'
    $wso2_am_db_url = 'jdbc:sqlserver://CF_RDS_URL:1433;databaseName=WSO2AM_APIMGT_DB;SendStringParametersAsUnicode=false'
    $am_db_url = 'jdbc:sqlserver://CF_RDS_URL:1433;databaseName=AM_DB;SendStringParametersAsUnicode=false'
    $db_driver_class_name = 'com.microsoft.sqlserver.jdbc.SQLServerDriver'
    $db_connector = 'mssql-jdbc-7.0.0.jre8.jar'
    $db_validation_query = 'SELECT 1'
  } elsif $db_managment_system == 'postgres' {
    $db_type = 'postgre'
    $reg_db_user_name = 'CF_DB_USERNAME'
    $um_db_user_name = 'CF_DB_USERNAME'
    $am_db_user_name = 'CF_DB_USERNAME'
    $wso2_reg_db_url = 'jdbc:postgresql://CF_RDS_URL:5432/WSO2AM_COMMON_DB'
    $wso2_um_db_url = 'jdbc:postgresql://CF_RDS_URL:5432/WSO2AM_COMMON_DB'
    $wso2_am_db_url = 'jdbc:postgresql://CF_RDS_URL:5432/WSO2AM_APIMGT_DB'
    $am_db_url = 'jdbc:postgresql://CF_RDS_URL:5432/AM_DB'
    $db_driver_class_name = 'org.postgresql.Driver'
    $db_connector = 'postgresql-42.2.5.jar'
    $db_validation_query = 'SELECT 1; COMMIT'
  }

  $wso2_am_db = {
    type              => $db_type,
    url               => $wso2_am_db_url,
    username          => $am_db_user_name,
    password          => $db_password,
    driver_class_name => $db_driver_class_name,
    validation_query  => $db_validation_query,
  }

  $wso2shared_db = {
    type              => $db_type,
    url               => $wso2_um_db_url,
    username          => $um_db_user_name,
    password          => $db_password,
    driver_class_name => $db_driver_class_name,
    validation_query  => $db_validation_query,
  }

  $am_db = {
    type              => $db_type,
    url               => $am_db_url,
    username          => $um_db_user_name,
    password          => $db_password,
    driver_class_name => $db_driver_class_name,
    validation_query  => $db_validation_query,
  }

  # ----- Carbon.xml config params -----
  $ports_offset = 0

  $key_store_location = 'wso2carbon.jks'
  $mi_key_store_location = 'repository/resources/security/wso2carbon.jks'
  $key_store_password = 'wso2carbon'
  $key_store_key_alias = 'wso2carbon'
  $key_store_key_password = 'wso2carbon'

  $internal_keystore_location = 'wso2carbon.jks'
  $internal_keystore_password = 'wso2carbon'
  $internal_keystore_key_alias = 'wso2carbon'
  $internal_keystore_key_password = 'wso2carbon'

  $trust_store_location = 'client-truststore.jks'
  $mi_trust_store_location = 'repository/resources/security/client-truststore.jks'
  $trust_store_password = 'wso2carbon'

  # ----- user-mgt.xml config params -----
  $admin_username = 'admin'
  $admin_password = 'admin'

  $token_exchange_enable = true
  $token_exchange_allow_refresh_tokens = true
  $token_exchange_iat_validity_period = '1h'
  
}
