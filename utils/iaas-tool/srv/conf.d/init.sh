#!/bin/bash

echo "Skyfall"
#tail -f /dev/null

##### bootstrap ####
yum -y install epel-release
yum -y install python-pip wget unzip tree
#yum -y install python36 python36-devel python36-setuptools
#easy_install-3.6 pip

#pip3 -vvvv install awscli --upgrade --user
pip install awscli
ls -la ~/.aws/
pwd
aws s3 ls --profile=infra-deploy-admin-lab

wget https://releases.hashicorp.com/terraform/0.12.1/terraform_0.12.1_linux_amd64.zip
unzip ./terraform_0.12.1_linux_amd64.zip -d /usr/local/bin/
chmod +x /usr/local/bin/terraform
terraform -v

######################

ls -la /data
echo $ENV_MOCK
cat /data/mock.txt
tree /data/sdk/
cd /data/sdk/

CMD=${1}



case "${CMD}" in
    "srv-adm")
        SRV=${2}
        ACTION=${3}
        ENV=${4}
        # "Uso: srv-adm <init|bootstrap|list|deploy|remove|status> <enviroment>"
        cd $SRV
        pwd
        ./srv-adm.sh $ACTION $ENV
        cd ..
        ;;
    "cfg-srv")
        ACTION=${2}
        SRV=${3}
        # "Uso: cfg-srv <init|bootstrap> <service>"
        #ls
        ./cfg-srv.sh $ACTION $SRV
        ;;

    *)
        echo "Uso: ${0} <srv-adm|cfg-srv> <service> <action> <enviroment>"
        exit 1
esac


