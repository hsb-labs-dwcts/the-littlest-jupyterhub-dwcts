#!/bin/sh

set -e

#
# install jupyterHub (bare metal)
#

doInstall() {
  # update
  sudo apt update
  # sudo apt upgrade -y
  
  # prerequisites
  sudo apt install -y build-essential  
  sudo apt install -y python3 python3-dev git curl  
  curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - && sudo apt install -y nodejs
  
  # installation
  curl -L https://raw.githubusercontent.com/hsb-labs-dwcts/the-littlest-jupyterhub-dwcts/main/bootstrap.py | sudo -E python3 - --admin admin
  
  # settings
  # change default user interface for users
  sudo tljh-config set user_environment.default_app jupyterlab
  
  # enable PAM authenticator
  # sudo tljh-config set auth.type jupyterhub.auth.PAMAuthenticator
  sudo tljh-config reload
  
  # jupyterlab ko-KR language pack
  sudo -E /opt/tljh/user/bin/conda install -c conda-forge -y \
    jupyterlab-language-pack-ko-KR
  # sudo sed -i 's/en_US/ko_KR/g' /home/jupyter-admin/.jupyter/lab/user-settings/@jupyterlab/translation-extension/plugin.jupyterlab-settings
  
  # extension
  # conda-forge
  sudo -E /opt/tljh/user/bin/conda install -c conda-forge -y \
    nodejs=16 \
    jupyterlab-git \
    jupyterlab-github \
    jupyterlab_execute_time \
    jupyterlab-variableinspector \
    jupyterlab-drawio \
    jupyterlab-lsp \
    python-lsp-server \
    ipywidgets \
    jupyter-archive
  
  # pypi
  sudo -E /opt/tljh/user/bin/pip install \
    jupyterlab-nvdashboard \
    nbconvert
    
  # extension list
  # sudo /opt/tljh/user/bin/jupyter server extension list
  
  # config
  # echo 'export PATH=$PATH:/opt/tljh/user/bin' >> ~/.bashrc
  # source ~/.bashrc
}

#
# 
#
doInstall
