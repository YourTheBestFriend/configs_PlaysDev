#!/bin/bash
# get aws variables
#source cred_vars
#access_id=$aws_access_key_id
#secret_access_key=$aws_secret_access_key
#region=$region
access_id=""
secret_access_key=""
region=""

# install AWCLI on dist
# or use # curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip" ; unzip awscliv2.zip ; sudo ./aws/install
# redhat
function install_on_redhat {
    sudo yum update -y
    sudo yum install -y python3-pip
    sudo pip3 install awscli
}
#debian
function install_on_debian {
    sudo apt -y update
    sudo apt -y install awscli
}
# windows
function install_on_windows {
    # install Invoke Tls12 for Security
    powershell.exe '$command = "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12"; Invoke-Expression $command ;
Invoke-WebRequest -Uri "https://awscli.amazonaws.com/AWSCLIV2.msi" -Outfile C:\AWSCLIV2.msi
$arguments = "/i `"C:\AWSCLIV2.msi`" /quiet" ; Start-Process msiexec.exe -ArgumentList $arguments -Wait ; 
echo "awscli installed"'
    # powerhsell => create cred
    powershell.exe "aws configure set aws_access_key_id $access_id ; aws configure set aws_secret_access_key $secret_access_key ; aws configure set region $region"
    # $? - set 0
    exit 0
}
# macos
function install_on_macos {
    curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
    sudo installer -pkg AWSCLIV2.pkg -target /
}

# function check OS and install awscli
function install_awscli {
    # check windows dist by WSL
    uname_type=$(uname -a | grep Microsoft)
    if [[ -n "$dist_type" || -n "$IS_WSL" ||  -n "$WSL_DISTRO_NAME" ]]; then
        echo 'WSL'
        #set $? 0
        install_on_windows
    else 
        # section for linux or MacOS
        uname_type=$(uname)
        if [[ "$uname_type" == "Linux" ]]; then
            dist_type=$(awk -F= '$1=="ID" { print $2 ;}' /etc/os-release)
            if [[ "$dist_type" == "ubuntu" ]]; then
                echo 'that is ubuntu'
                install_on_debian
            elif [[ "$dist_type" == "\"rhel\"" ]]; then
                echo 'that is rhel'
                install_on_redhat
            fi
        elif [[ "$uname_type" == "Darwin" ]]; then 
            echo 'that is MacOS'
            install_on_macos
        fi
    fi
}

# instarll awscli
install_awscli 
# if install_awscli (exit code not bad - start set_cred)
aws configure set aws_access_key_id $access_id
aws configure set aws_secret_access_key $secret_access_key
aws configure set region $region