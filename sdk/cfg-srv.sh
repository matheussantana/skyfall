#!/usr/bin/env bash
#set -x
ACTION="${1}"
SERVICE="${2}"

setup_config () {


    mkdir -p $SERVICE

    cd $SERVICE/
    rm srv-adm.sh global-variables.tf provider.tf versions.tf
    cd ..


    ln -s ../shared/srv-adm.sh $SERVICE/srv-adm.sh
    ln -s ../shared/global-variables.tf $SERVICE/global-variables.tf
    ln -s ../shared/provider.tf $SERVICE/provider.tf
    ln -s ../shared/versions.tf $SERVICE/versions.tf

    ls -la $SERVICE

}

bootstrap () {

    rm $SERVICE/mock.*

    #cp ./test/$SERVICE/fs-buckets3.tf $SERVICE/mock.fs-buckets3.tf
    #cp ./test/$SERVICE/nosql-dynamodb.tf $SERVICE/mock.nosql-dynamodb.tf
    #cp ./test/$SERVICE/queue-sqs.tf $SERVICE/mock.queue-sqs.tf

    cd ./test/$SERVICE/
    for f in *.tf; do
         cp -v "$f" "../../$SERVICE/mock.$f";
    done
    cd ../../

    ls -la $SERVICE/mock.*
}

echo "Skyfall Infra Config Tool"

case "${ACTION}" in
    "init")
        setup_config
        ;;
    "bootstrap")
        bootstrap ;;
    *)
        echo "Uso: ${0} <init|bootstrap> <service>"
        exit 1
esac
