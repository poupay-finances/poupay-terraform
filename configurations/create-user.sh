#!/bin/bash

password="urubu100"
name_prefix="sptech"
group="sudoers"

username="${name_prefix}"
useradd -m -d /home/${username} -p $(openssl passwd -1 ${password}) -s /bin/bash ${username}
chown -R ${username} /home/${username}
echo "User ${username} created!"
