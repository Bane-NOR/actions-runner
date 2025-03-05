#!/bin/bash
# This script is used to install the tools required for the platform.

# 01. Terraform
echo "Installing Terraform..."
curl https://releases.hashicorp.com/terraform/1.9.7/terraform_1.9.7_linux_amd64.zip -o terraform.zip && unzip terraform.zip && sudo mv terraform /usr/local/bin/terraform && rm terraform.zip
echo "Terraform installed successfully."

# 02. Azure CLI
echo "Installing Azure CLI..."
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
echo "Azure CLI installed successfully."

echo "Installing kubectl and kubelogin..."
sudo az aks install-cli
echo "kubectl and kubelogin installed successfully."

# 03. Various k8s tools
# 03.01. helm
echo "Installing helm..."
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm
# 03.02. trivy
echo "Installing trivy..."
curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin
echo "k8s tools installed successfully."

curl -fsSL https://deb.nodesource.com/setup_22.x | sudo bash -
sudo apt-get install -y nodejs
npx playwright install --with-deps
npm install -D @playwright/test@1.50.1
npm i create-playwright --quiet --with-deps
sudo npm install -g @usebruno/cli@1.39.0
sudo npm install -g dotenv-cli@8.0.0
npm install -D typescript@5.8.2
npm install --save @types/node@22.13.9

# # 04. Bruno
echo "Installing Bruno..."
curl -sfL https://github.com/usebruno/bruno/releases/download/v1.33.0/bruno_1.33.0_amd64_linux.deb -o bruno.deb
sudo apt install libgtk-3-0 libnotify4 libnss3 libxss1 libxtst6 xdg-utils libatspi2.0-0 libsecret-1-0 -y
sudo dpkg -i bruno.deb && rm bruno.deb && echo "Bruno installed successfully."

# 05. gh cli
echo "Installing gh cli..."
(type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
	&& wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y && echo "gh cli installed successfully."
