# Skyfall - Write Once Deploy Everywhere!

Skyfall is a open-source SDK library (“abstraction layer”) for scheduling and management of high-available, secure and scalable infrastructure resources.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

It's possible to run this project in two ways. Run locally the **cfg-srv/srv-adm** tools or through a **docker-container**.

For **local** run: - example on Centos 7 (see official docs for other OS distributions).
Install pip package manager and the aws-cli tool
```
yum -y install epel-release
yum -y install python-pip wget unzip tree
pip install awscli
```
Install terraform.
```
wget https://releases.hashicorp.com/terraform/0.12.1/terraform_0.12.1_linux_amd64.zip
unzip ./terraform_0.12.1_linux_amd64.zip -d /usr/local/bin/
chmod +x /usr/local/bin/terraform
terraform -v
```

For **docker** see the [official instructions] (https://docs.docker.com/v17.12/install/)

Setting AWS Credentials - [official docs] (https://docs.aws.amazon.com/sdk-for-java/v1/developer-guide/setup-credentials.html)

Setting your credentials for use can be done in a number of ways, but here are the recommended approaches:
Set credentials in the AWS credentials profile file on your local system, located at:
```
~/.aws/credentials on Linux, macOS, or Unix
C:\Users\USERNAME\.aws\credentials on Windows
```

This file should contain lines in the following format:

```
[default]
aws_access_key_id = your_access_key_id
aws_secret_access_key = your_secret_access_key
```
Substitute your own AWS credentials values for the values your_access_key_id and your_secret_access_key.


### Installing

The first thing you have to do is create the service workspace by cloning/fork/copy the main project.

```
git clone https://skyfal-repo-abc.local.com
```
This is were you resources will be declared and configured.

The source code tree is as follows:
```
.
├── LICENSE
├── README.md
├── sdk
│   ├── cfg-srv.sh
│   ├── infra
│   │   ├── backend.tf -> ./envs/lab/backend.tf
│   │   ├── envs
│   │   │   └── lab
│   │   │       ├── backend.tf
│   │   │       └── input_parameters.tfvars
│   │   ├── global-variables.tf -> ../shared/global-variables.tf
│   │   ├── mock.cache-elasticache-redis.tf
│   │   ├── mock.fs-buckets3.tf
│   │   ├── mock.nosql-dynamodb.tf
│   │   ├── mock.queue-sqs.tf
│   │   ├── provider.tf -> ../shared/provider.tf
│   │   ├── srv-adm.sh -> ../shared/srv-adm.sh
│   │   ├── terraform.tfvars -> ./envs/lab/input_parameters.tfvars
│   │   └── versions.tf -> ../shared/versions.tf
│   ├── modules
│   │   ├── compute
│   │   ├── database
│   │   │   └── core
│   │   │       └── dynamodb
│   │   │           └── main.tf
│   │   ├── fileserver
│   │   │   └── core
│   │   │       └── bucket-s3
│   │   │           └── main.tf
│   │   ├── middleware
│   │   │   └── core
│   │   │       ├── queue-with-dlq-sqs
│   │   │       │   └── main.tf
│   │   │       └── standalone-queue-sqs
│   │   │           └── main.tf
│   │   ├── network
│   │   │   ├── core
│   │   │   │   ├── elasticache-subnet-group
│   │   │   │   │   └── main.tf
│   │   │   │   ├── firewall-security-group
│   │   │   │   │   └── main.tf
│   │   │   │   ├── firewall-security-group-rule-id-based
│   │   │   │   │   └── main.tf
│   │   │   │   └── firewall-security-group-rule-ip-based
│   │   │   │       └── main.tf
│   │   │   └── ext
│   │   ├── security
│   │   │   ├── core
│   │   │   │   └── iam
│   │   │   │       ├── attach-user-policy
│   │   │   │       │   └── main.tf
│   │   │   │       ├── policy
│   │   │   │       │   ├── main.tf
│   │   │   │       │   └── variables.tf
│   │   │   │       ├── role
│   │   │   │       │   ├── main.tf
│   │   │   │       │   ├── output.tf
│   │   │   │       │   └── variables.tf
│   │   │   │       ├── role-policy
│   │   │   │       │   ├── main.tf
│   │   │   │       │   └── variables.tf
│   │   │   │       └── user
│   │   │   │           ├── main.tf
│   │   │   │           ├── output.tf
│   │   │   │           └── variables.tf
│   │   │   └── ext
│   │   │       └── auth
│   │   │           ├── CreateAccessProfile
│   │   │           │   ├── main.tf
│   │   │           │   └── variables.tf
│   │   │           └── GrantAccessTo_ACL
│   │   │               └── main.tf
│   │   └── storage
│   │       └── core
│   │           ├── elasticache-HA-cluster-redis
│   │           │   └── main.tf
│   │           └── elasticache-standard-cluster-redis
│   │               └── main.tf
│   ├── security
│   │   ├── backend.tf -> ./envs/lab/backend.tf
│   │   ├── envs
│   │   │   └── lab
│   │   │       ├── backend.tf
│   │   │       └── input_parameters.tfvars
│   │   ├── global-variables.tf -> ../shared/global-variables.tf
│   │   ├── header.tf
│   │   ├── mock.cache-subnet-group.tf
│   │   ├── mock.network-firewall.tf
│   │   ├── mock.resource-access-control.tf
│   │   ├── mock.storage-s3-fs-backend.tf
│   │   ├── provider.tf -> ../shared/provider.tf
│   │   ├── srv-adm.sh -> ../shared/srv-adm.sh
│   │   ├── terraform.tfvars -> ./envs/lab/input_parameters.tfvars
│   │   └── versions.tf -> ../shared/versions.tf
│   ├── shared
│   │   ├── CONTRIBUTING.md
│   │   ├── global-variables.tf
│   │   ├── LICENSE
│   │   ├── provider.tf
│   │   ├── README.md
│   │   ├── srv-adm.sh
│   │   └── versions.tf
│   └── test
│       ├── infra
│       │   ├── cache-elasticache-redis.tf
│       │   ├── fs-buckets3.tf
│       │   ├── nosql-dynamodb.tf
│       │   └── queue-sqs.tf
│       └── security
│           ├── cache-subnet-group.tf
│           ├── network-firewall.tf
│           ├── resource-access-control.tf
│           └── storage-s3-fs-backend.tf
└── utils
    └── iaas-tool
        ├── docker-compose.yml
        ├── srv
        │   ├── conf.d
        │   │   ├── exec.sh
        │   │   └── init.sh
        │   ├── data
        │   │   ├── iaas
        │   │   ├── mock.txt
        │   │   └── sdk
        │   └── Dockerfile
        └── start-workflow.sh

58 directories, 79 files

```

## Core components


| File/Dir  | Description |
| ------------- | ------------- |
| sdk/  | Core component which contains the source-code for all tools,scripts and templates|
| sdk/modules/  | Source-code for reusable infrastructure modules |
| sdk/shared/| Shared/Common configuration files between all services and environments |
| sdk/test/| Mock workflow files for test |
| sdk/_service/  | Service workspace |
| sdk/_service/envs/*/| A service can have multiple environments like dev, stage, qa, prod...|
| sdk/_service/envs/*/backend.tf | Terraform configuration file that store and manage the infra. state|
| sdk/_service/envs/*/input_parameters.tfvars| Input parameters for dynamic environment variables |
| sdk/security/| Privileged workspace for security and network resources deployment|
| sdk/infra/| General purpose infrastructure resource workflow manager|
| sdk/_service/srv-adm.sh  | Service Deployment tool |
| sdk/_service/cfg-srv.sh  | Service Configuration tool |
| utils/ | helper tools to use and manage the deployment pipeline |
| utils/iaas-tool | docker container tool to automate task execution |


## Quick start

### Service: Security workspace - Privileged mode


Before we start to create the resources we first have to configure service and environment parameters.
But first let's create the **security** service workspace using the utils tool.

For container-based:
```
$ cd utils/iaas-tool/
$ ls
docker-compose.yml  srv  start-workflow.sh
```
Open the **docker-compose.yml** and uncomment the security service line:

```
....
# configure/setup service environment

command: ./tmp/init.sh cfg-srv init security
...
```

Then run the **star-workflow** tool:

```
$ ./start-workflow.sh
Building infra-workflow-manager
Step 1/7 : FROM centos:latest
 ---> 49f7960eb7e4
Step 2/7 : ADD ./conf.d/exec.sh /tmp/exec.sh
 ---> Using cache
 ---> 48bd4c0d7ff5
Step 3/7 : RUN ["chmod", "+x", "/tmp/exec.sh"]
 ---> Using cache
 ---> f637f3c12b38
Step 4/7 : CMD /bin/bash /tmp/exec.sh
 ---> Using cache
 ---> cdb3b9d4f4eb
Step 5/7 : RUN  cat /etc/redhat-release
 ---> Using cache
 ---> e9d9c2eaa408
Step 6/7 : ADD ./conf.d/init.sh /tmp/init.sh
 ---> Using cache
 ---> 1fe3d3924f20
Step 7/7 : RUN ["chmod", "+x", "/tmp/init.sh"]
 ---> Using cache
 ---> c8dacd83403f
Successfully built c8dacd83403f
Successfully tagged iaastool_infra-workflow-manager:latest
Recreating iaastool_infra-workflow-manager_1 ...
Recreating iaastool_infra-workflow-manager_1 ... done
Attaching to iaastool_infra-workflow-manager_1
infra-workflow-manager_1  | Skyfall
infra-workflow-manager_1  | Loaded plugins: fastestmirror, ovl

....

infra-workflow-manager_1  | Skyfall Infra Config Tool
infra-workflow-manager_1  | total 44
infra-workflow-manager_1  | drwxrwxr-x 5 268537125 268537125 4096 Jun  7 16:44 .
infra-workflow-manager_1  | drwxrwxr-x 7 268537125 268537125 4096 Jun  7 15:23 ..
infra-workflow-manager_1  | drwxrwxr-x 2 268537125 268537125 4096 Jun  4 20:55 .draft
infra-workflow-manager_1  | drwxrwxr-x 4 268537125 268537125 4096 Jun  6 14:15 .terraform
infra-workflow-manager_1  | lrwxrwxrwx 1 root      root        21 Jun  7 15:30 backend.tf -> ./envs/lab/backend.tf
infra-workflow-manager_1  | drwxrwxr-x 3 268537125 268537125 4096 Jun  5 21:03 envs
infra-workflow-manager_1  | lrwxrwxrwx 1 root      root        29 Jun  7 16:44 global-variables.tf -> ../shared/global-variables.tf
infra-workflow-manager_1  | -rw-rw-r-- 1 268537125 268537125   69 Jun  4 20:33 header.tf
infra-workflow-manager_1  | -rw-rw-r-- 1 268537125 268537125  335 Jun  5 22:27 mock.cache-subnet-group.tf
infra-workflow-manager_1  | -rw-rw-r-- 1 268537125 268537125 1369 Jun  6 14:12 mock.network-firewall.tf
infra-workflow-manager_1  | -rw-rw-r-- 1 268537125 268537125 5675 Jun  6 14:22 mock.resource-access-control.tf
infra-workflow-manager_1  | -rw-rw-r-- 1 268537125 268537125  300 Jun  6 14:18 mock.storage-s3-fs-backend.tf
infra-workflow-manager_1  | lrwxrwxrwx 1 root      root        21 Jun  7 16:44 provider.tf -> ../shared/provider.tf
infra-workflow-manager_1  | lrwxrwxrwx 1 root      root        20 Jun  7 16:44 srv-adm.sh -> ../shared/srv-adm.sh
infra-workflow-manager_1  | lrwxrwxrwx 1 root      root        34 Jun  7 15:30 terraform.tfvars -> ./envs/lab/input_parameters.tfvars
infra-workflow-manager_1  | lrwxrwxrwx 1 root      root        21 Jun  7 16:44 versions.tf -> ../shared/versions.tf

```

The **security** service is a privileged workspace that creates all service/end users, access policies and is responsible to allow/deny access control all resources.
Now lets create a service environment (like dev,stage,lab,prod,qa,etc...).
For this edit the docker-compose.yml file and run the start-workflow.sh:

```
    command: ./tmp/init.sh srv-adm security bootstrap lab

```

This will create the ./service/lab/**backend.tf** and **input_parameters.tf** files with empty standard values. Open those files and set the correct values.

```
security/
├── backend.tf -> ./envs/lab/backend.tf
├── envs
│   └── lab
│       ├── backend.tf
│       └── input_parameters.tfvars
├── global-variables.tf -> ../shared/global-variables.tf
├── header.tf
├── provider.tf -> ../shared/provider.tf
├── srv-adm.sh -> ../shared/srv-adm.sh
├── terraform.tfvars -> ./envs/lab/input_parameters.tfvars
└── versions.tf -> ../shared/versions.tf

```

Optionally if you want to create some mock template files for the resource as well run the **cfg-srv** with the **bootstrap** parameter:

For this edit the docker-compose.yml file and run the start-workflow.sh:

```
    command: ./tmp/init.sh cfg-srv bootstrap security

```

This operation will create all the mock* files for the security and network resources:

```
security/
├── backend.tf -> ./envs/lab/backend.tf
├── envs
│   └── lab
│       ├── backend.tf
│       └── input_parameters.tfvars
├── global-variables.tf -> ../shared/global-variables.tf
├── header.tf
├── mock.cache-subnet-group.tf
├── mock.network-firewall.tf
├── mock.resource-access-control.tf
├── mock.storage-s3-fs-backend.tf
├── provider.tf -> ../shared/provider.tf
├── srv-adm.sh -> ../shared/srv-adm.sh
├── terraform.tfvars -> ./envs/lab/input_parameters.tfvars
└── versions.tf -> ../shared/versions.tf


```

For example, lets see the **mock.resource-access-control.tf** file bellow. It creates all required permissions for service/end users to create and manage the given infra. resources.

```
############################
# User/Service Credentials #
# Module: CreateAcessProfile
############################

module "CreateAcessProfile_AdminProfile" {
  source = "../modules/security/ext/auth/CreateAccessProfile"
  username = "admin-user-app-mock"
  namespace = var.namespace
  target_service = "ec2.amazonaws.com"
  access_level = "Allow"
  role_name = "admin-role-app-mock"
}

output "AuthProfile_AdminProfile" {
  value = module.CreateAcessProfile_AdminProfile
}
...

###
# Policy S3 - Fileserver S3
# Module: GrantAccessTo_ACL
###

module "S3FS_GrantAccessTo_ACL_Adm" {
  source = "../modules/security/ext/auth/GrantAccessTo_ACL"
  policy_name = "s3_acl"
  namespace = var.namespace
  access_level = "Allow"
  target_service = "s3"
  operation_list = ["*"]
  prefix = ""

  target_resource_id_list = ["s3-fileserver-mock*", "s3-fileserver-mock*"]

  #target_resource_id_list = ["s3-fileserver-mock-${random_integer.value.id}*", "s3-fileserver-mock-${random_integer.value.id}*"]

  region = ""
  account-id = ""

  target_user_name = module.CreateAcessProfile_AdminProfile.aws-user.user.name
  target_role_name = module.CreateAcessProfile_AdminProfile.aws-role.access_role.name
}

output "S3FS_AcessControl_PolicyRule_Adm" {
  value = module.S3FS_GrantAccessTo_ACL_Adm.policy
}


```
Before deploying the resources we need to initialize the service. This operations dowloads all modules and configures the backend used to store the required metadata (like tfstate files).

Go back to **utils/iaas-tool/docker-compose.yml**, edit the line and run the **start-workflow**:

```
...

    # create lab environments

    #command: ./tmp/init.sh srv-adm security bootstrap lab
    command: ./tmp/init.sh srv-adm security init lab

...
```

Now lets deploy this workflow in order to create all the security components we need.
Go back to **utils/iaas-tool/docker-compose.yml**, edit the line and run the **start-workflow**:

```
...

    # deploy & remove service environment

    #command: ./tmp/init.sh srv-adm security status lab
    command: ./tmp/init.sh srv-adm security deploy lab
    #command: ./tmp/init.sh srv-adm security remove lab

...
```



### Service: Infra workspace

After creating the security service you have the required service users, roles, permissions and credentials required to deploy infra. resources.
Follow the same steps you did for the security layer but remember to update the **./infra/envs/{backend,input_paraments}.tf** with the service user, storage, credentials, resource-ids, etc created by the *Security* service earlier.
```
    # configure/setup service environment

    #command: ./tmp/init.sh cfg-srv init infra
    
    # create lab environment
    #command: ./tmp/init.sh srv-adm infra bootstrap lab
```

After setting the correct credentials, users and ids you can run each infra. workflow action..

```

    # deploy & remove service environment

    #command: ./tmp/init.sh srv-adm infra status lab
    #command: ./tmp/init.sh srv-adm infra deploy lab
    #command: ./tmp/init.sh srv-adm infra remove lab

```

## Deployment

Commands overview:

```
# configure/setup service environment

# security & network
cfg-srv init security

# create lab environment

srv-adm security bootstrap lab
cfg-srv bootstrap security

# deploy & remove service environment

srv-adm security status lab
srv-adm security deploy lab
srv-adm security remove lab


# infra
# configure/setup service environment

cfg-srv init infra

# create lab environment

srv-adm infra bootstrap lab

# deploy & remove service environment

srv-adm infra status lab
srv-adm infra deploy lab
srv-adm infra remove lab


```

## Deployment

Add additional notes about how to deploy this on a live system

## Built With

* [Terraform](http://terraform.io/) -  Infrastructure as Code
* [aws-cli](https://docs.aws.amazon.com/cli/index.html) - AWS Command Line Interface
* [docker](https://www.docker.com/) - Container Platform
* [docker-compose](https://docs.docker.com/compose/) - Container Deploy Tool

## Contributing

Please read [CONTRIBUTING.md]() for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags).

## Authors

* **Matheus S. Lima** - *Initial work* - [Skyfall](https://github.com/matheussantana/skyfall/)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

    Licensed to the Apache Software Foundation (ASF) under one
    or more contributor license agreements.  See the NOTICE file
    distributed with this work for additional information
    regarding copyright ownership.  The ASF licenses this file
    to you under the Apache License, Version 2.0 (the
    "License"); you may not use this file except in compliance
    with the License.  You may obtain a copy of the License at

      https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.



## Acknowledgments

