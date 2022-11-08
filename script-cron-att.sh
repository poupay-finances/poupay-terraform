touch /cron-redundancy.sh
chmod +x /cron-redundancy.sh

echo "#!/bin/bash" > /cron-redundancy.sh
echo "BUCKETS=$(aws s3 ls | awk '{print $3}')" >> /cron-redundancy.sh
echo "AZURE_FS=$(ls /mnt)" >> /cron-redundancy.sh
echo "for bucket in $BUCKETS; do" >> /cron-redundancy.sh
echo "    for fs in $AZURE_FS; do" >> /cron-redundancy.sh
echo "        if [ $bucket == $fs ]; then" >> /cron-redundancy.sh
echo "            FILESBUCKET=$(aws s3 ls $bucket | awk '{print $4}')" >> /cron-redundancy.sh
echo "            FILESFS=$(ls /mnt/$fs)" >> /cron-redundancy.sh
echo "            for filebt in $FILESBUCKET; do" >> /cron-redundancy.sh
echo "                if [[ $FILESFS =~ (' '|^)$filebt(' '|$) ]];" >> /cron-redundancy.sh
echo "                    then echo 'Arquivo existe no fs!'" >> /cron-redundancy.sh
echo "                    else aws s3 cp s3://$bucket/$filebt /mnt/$fs/" >> /cron-redundancy.sh
echo "                fi" >> /cron-redundancy.sh
echo "            done" >> /cron-redundancy.sh
echo "            for filefs in $FILESFS; do" >> /cron-redundancy.sh
echo "                if [[ $FILESBUCKET =~ (' '|^)$filefs(' '|$) ]];" >> /cron-redundancy.sh
echo "                    then echo 'Arquivo existe no bucket!'" >> /cron-redundancy.sh
echo "                    else aws s3 cp /mnt/$fs/$filefs s3://$bucket" >> /cron-redundancy.sh
echo "                fi" >> /cron-redundancy.sh
echo "            done" >> /cron-redundancy.sh
echo "        fi" >> /cron-redundancy.sh
echo "    done" >> /cron-redundancy.sh
echo "done" >> /cron-redundancy.sh