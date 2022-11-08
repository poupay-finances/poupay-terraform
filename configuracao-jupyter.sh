#!/bin/bash
amazon-linux-extras install java-openjdk11 -y
curl -O https://dlcdn.apache.org/spark/spark-3.2.1/spark-3.2.1-bin-hadoop3.2.tgz
tar xzf spark-3.2.1-bin-hadoop3.2.tgz -C /usr/local --owner root --group root --no-same-owner
rm -rf spark-3.2.1-bin-hadoop3.2.tgz
mv /usr/local/spark-3.2.1-bin-hadoop3.2 /usr/local/spark
pip3 install pyspark --no-cache-dir
pip3 install jupyterlab --no-cache-dir
touch /lib/systemd/system/jupyter.service
echo "[Unit]" >> /lib/systemd/system/jupyter.service
echo "Description=Jupyter Notebook" >> /lib/systemd/system/jupyter.service
echo "[Service]" >> /lib/systemd/system/jupyter.service
echo "Type=simple" >> /lib/systemd/system/jupyter.service
echo "ExecStart=/opt/jupyter/script/start.sh" >> /lib/systemd/system/jupyter.service
echo "Restart=always" >> /lib/systemd/system/jupyter.service
echo "RestartSec=10" >> /lib/systemd/system/jupyter.service
echo "[Install]" >> /lib/systemd/system/jupyter.service
echo "WantedBy=multi-user.target" >> /lib/systemd/system/jupyter.service
mkdir /opt/jupyter
mkdir /opt/jupyter/notebook
mkdir /opt/jupyter/script
touch /opt/jupyter/script/start.sh
echo '#!/bin/bash' >> /opt/jupyter/script/start.sh
echo '/usr/bin/python3 -m notebook --NotebookApp.notebook_dir=/opt/jupyter/notebook --NotebookApp.password=$(/usr/bin/python3 -c "from notebook.auth import passwd; print(passwd(\"${jupyter_pass}\"))")  --allow-root --ip 0.0.0.0 --port 80' >> /opt/jupyter/script/start.sh
chmod +x /opt/jupyter/script/start.sh
systemctl daemon-reload
systemctl start jupyter
systemctl enable jupyter