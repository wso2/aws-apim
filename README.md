# AWS Resources for WSO2 API Manager

This repository contains CloudFormation templates to deploy WSO2 API Manager in Amazon Web Services(AWS).
In this pattern, 2 API Manager instances will be deployed with a single Micro Integrator instance that are connected via a 
single Load Balancer.

The WSO2 APIM CloudFormation templates use Puppet to manage the server configurations and use the following AMI's to provision the deployment.

1. Puppetmaster AMI - Contains the API Manager GA distribution and Puppet modules containing the configurations for APIM deployment patterns.

2. APIM AMI - Contains the scripts that are required to create the Puppet catalog.

3. Micro-Integrator AMI - Contains the scripts that are required to create the Puppet catalog.

First the Puppetmaster AMI would deploy and afterwards the product specific AMI's would deploy and request the necessary configurations from the Puppetmaster AMI to deploy the WSO2 API Manager.

## FAQ

####1. Why do I get ``"MasterUsername Admin cannot be used as it is a reserved word used by the engine"`` error, when I try to deploy the setup with Postgres DB?
    
You cannot use "Admin" as the DBUsername when you use Postgres as your DB. Use a different DB Username.

   
####2. How do I fix ``ERROR {ServiceCatalogUtils} - Error occurred while reading the response from service catalog javax.net.ssl.SSLHandshakeException: PKIX path building failed: sun.security.provider.certpath.SunCertPathBuilderException: unable to find valid certification path to requested target`` error from the Micro Integrator, which is raised when I deploy a CAPP to the service catalog?
   
As mentioned in [pattern-1/README.md](pattern-1/README.md), before creating the stack you have to add a Server Certificate to AWS using ACM or IAM as explained [here](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_server-certs.html).
You have to add the same certificate to `{MI_HOME}/repository/resources/security/` directory using the below command.

    >>> keytool -import -alias servercert -file /home/ubuntu/certificate.crt -storetype JKS -keystore client-truststore.jks
Replace `/home/ubuntu/certificate.crt` with the path to your certificate.

####3. What is the reason for getting ``ERROR {org.wso2.micro.integrator.initializer.utils.ServiceCatalogUtils} - Environment variables are not configured correctly org.apache.synapse.commons.resolvers.ResolverException: Environment variable could not be found`` in Micro Integrator?

You will get this error when you try to deploy a CAPP with parameterized URL to service catalog. This is because, environment variables are not set for `MI_HOST` and `MI_PORT`.
For setting up the environment variables within the MI Instance, switch as the root user and execute below commands. 
   
    >>> export MI_HOST=[Micro-Integrator Hostname]
    >>> export MI_PORT=8290
   
Later, restart the Micro-Integrator by executing `sh {MI_HOME}/bin/micro-integrator.sh restart` as the root user.
