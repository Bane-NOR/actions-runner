#!/bin/bash
# This script is used to install the tools required for the platform.

# 01. Terraform
echo "Installing Terraform..."
curl https://releases.hashicorp.com/terraform/1.9.7/terraform_1.9.7_linux_amd64.zip -o terraform.zip && unzip terraform.zip && mv terraform /usr/local/bin/terraform && rm terraform.zip
echo "Terraform installed successfully."

# 02. Azure CLI
echo "Installing Azure CLI..."
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
echo "Azure CLI installed successfully."

echo "Installing kubectl and kubelogin..."
az aks install-cli
echo "kubectl and kubelogin installed successfully."

# 03. Various k8s tools
# 03.01. helm
echo "Installing helm..."
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm
echo "Installing trivy..."
curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin
echo "k8s tools installed successfully."

# 04. Bruno
echo "Installing Bruno..."
sudo mkdir -p /etc/apt/keyrings 
sudo gpg --no-default-keyring --keyring /etc/apt/keyrings/bruno.gpg --keyserver keyserver.ubuntu.com --recv-keys 9FA6017ECABE0266

echo "deb [signed-by=/etc/apt/keyrings/bruno.gpg] http://debian.usebruno.com/ bruno stable" | sudo tee /etc/apt/sources.list.d/bruno.list
sudo apt update
sudo apt install bruno
echo "Bruno installed successfully."