#!/bin/bash
# This script is used to install the tools required for the platform.

# 01. Terraform
echo "Installing Terraform..."
curl https://releases.hashicorp.com/terraform/1.12.0/terraform_1.12.0_linux_amd64.zip -o terraform.zip && unzip terraform.zip && sudo mv terraform /usr/local/bin/terraform && rm terraform.zip
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
sudo apt-get install curl gpg apt-transport-https --yes
curl -fsSL https://packages.buildkite.com/helm-linux/helm-debian/gpgkey | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/helm.gpg] https://packages.buildkite.com/helm-linux/helm-debian/any/ any main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm
# 03.02. trivy
echo "Installing trivy..."
curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sudo sh -s -- -b /usr/local/bin
echo "k8s tools installed successfully."

curl -fsSL https://deb.nodesource.com/setup_22.x | sudo bash -
sudo apt-get install -y nodejs python3.11 python3-pip python3-venv python3.11-venv
npx playwright install --with-deps
npm install -D @playwright/test@1.50.1
npm i create-playwright --quiet --with-deps
sudo npm install -g @usebruno/cli@1.39.0
sudo npm install -g dotenv-cli@8.0.0
npm install -D typescript@5.8.2
npm install --save @types/node@22.13.9


## Dataplatform tooling
python3.11 -m pip install pipx==1.7.1
pipx install uv==0.7.3
curl -fsSL https://raw.githubusercontent.com/databricks/setup-cli/v0.250.0/install.sh | sudo sh

# # 04. Bruno
echo "Installing Bruno..."
curl -sfL https://github.com/usebruno/bruno/releases/download/v2.3.0/bruno_2.3.0_amd64_linux.deb -o bruno.deb
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

# 06. ORAS
echo "Installing oras..."
VERSION="1.2.2"
curl -LO "https://github.com/oras-project/oras/releases/download/v${VERSION}/oras_${VERSION}_linux_amd64.tar.gz"
mkdir -p oras-install/
tar -zxf oras_${VERSION}_*.tar.gz -C oras-install/
sudo mv oras-install/oras /usr/local/bin/
rm -rf oras_${VERSION}_*.tar.gz oras-install/
