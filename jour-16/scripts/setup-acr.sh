#!/bin/bash
# scripts/setup-acr.sh

set -e

ACR_NAME="tfmodules${RANDOM}${RANDOM}"
RESOURCE_GROUP="rg-terraform-registry"
LOCATION="canadacentral"

# Création du groupe de ressources
az group create --name $RESOURCE_GROUP --location $LOCATION

# Création du registre ACR
az acr create \
    --name $ACR_NAME \
    --resource-group $RESOURCE_GROUP \
    --sku Basic \
    --admin-enabled false

# Activer le stockage OCI (pour modules Terraform)
az acr update --name $ACR_NAME --allow-trusted-services true

# Créer un Service Principal pour CI/CD
# SP_NAME="sp-terraform-registry"

# az ad sp create-for-rbac \
#     --name $SP_NAME \
#     --role acrpush \
#     --scopes /subscriptions/$(az account show --query id -o tsv)/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.ContainerRegistry/registries/$ACR_NAME \
#     --sdk-auth

echo "ACR_NAME=$ACR_NAME"
echo "ACR_LOGIN_SERVER=$ACR_NAME.azurecr.io"