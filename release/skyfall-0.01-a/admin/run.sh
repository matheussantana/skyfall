#!/usr/bin/env bash
#set -x
ACTION="${1}"
ENVIRONMENT="${2}"
AUTO_INIT=0
setup_config () {
        rm backend.tf && rm terraform.tfvars
        # rm variables.tf
        mkdir -p ./envs/"${ENVIRONMENT}"/
        ln -s ./envs/"${ENVIRONMENT}"/backend.tf backend.tf
        ln -s ./envs/"${ENVIRONMENT}"/input_parameters.tfvars terraform.tfvars
        #ln -s ./envs/"${ENVIRONMENT}"/variables.tf variables.tf

        ls -la variables.tf backend.tf

}


case "${ACTION}" in
    "setup")
        setup_config
        terraform init
        ;;
    "deploy")
        setup_config
        if [ $AUTO_INIT != 0 ]
        then
            terraform init
        fi

        terraform apply ;;

    "list")
        ls -la | grep -e 'input_parameters.tfvars' -e 'backend.tf'
        echo "Enviroments : "
        ls envs ;;
    "remove")
        terraform destroy ;;
    "status")
        terraform plan && tree . ;;

    *)
        echo "Uso: ${0} <setup|list|deploy|remove|status> <enviroment>"
        exit 1
esac
