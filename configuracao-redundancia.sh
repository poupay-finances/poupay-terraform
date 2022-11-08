#!/bin/bash
apt-get -y upgrade
apt-get -y update
apt-get install -y awscli cifs-utils

echo "[default]" > /home/ubuntu/.aws/credentials
echo ${aws_access_key_id} >> /home/ubuntu/.aws/credentials
echo ${aws_secret_access_key} >> /home/ubuntu/.aws/credentials
echo ${aws_session_token} >> /home/ubuntu/.aws/credentials

echo "[default]" > /root/.aws/credentials
echo ${aws_access_key_id} >> /root/.aws/credentials
echo ${aws_secret_access_key} >> /root/.aws/credentials
echo ${aws_session_token} >> /root/.aws/credentials

echo "[default]" > /home/ubuntu/.aws/config
echo "region = us-east-1" >> /home/ubuntu/.aws/config
echo "output = json" >> /home/ubuntu/.aws/config

echo "[default]" > /root/.aws/config
echo "region = us-east-1" >> /root/.aws/config
echo "output = json" >> /root/.aws/config

if [ ! -d "/etc/smbcredentials" ]; then
        mkdir /etc/smbcredentials
fi

if [ ! -f "/etc/smbcredentials/\"${sa_name}\".cred" ]; then
        bash -c 'echo "username=${sa_name}" >> /etc/smbcredentials/${sa_name}.cred'
        bash -c 'echo "password=${sa_key}" >> /etc/smbcredentials/${sa_name}.cred'
fi

chmod 600 /etc/smbcredentials/${sa_name}.cred

for fs in ${fs_name}; do
        mkdir /mnt/$fs
        bash -c 'echo "//${sa_name}.file.core.windows.net/$fs /mnt/$fs cifs nofail,credentials=/etc/smbcredentials/${sa_name}.cred,dir_mode=0777,file_mode=0777,serverino,nosharesock,actimeo=30" >> /etc/fstab'
        mount -t cifs //${sa_name}.file.core.windows.net/$fs /mnt/$fs -o credentials=/etc/smbcredentials/${sa_name}.cred,dir_mode=0777,file_mode=0777,serverino,nosharesock,actimeo=30
done