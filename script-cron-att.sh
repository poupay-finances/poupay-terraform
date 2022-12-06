touch /cron-redundancy.sh
chmod +x /cron-redundancy.sh

#!/bin/bash
BUCKETS=$(aws s3 ls | awk '{print $3}')
AZURE_FS=$(ls /mnt)
for bucket in $BUCKETS; do
    for fs in $AZURE_FS; do
        if [ $bucket == $fs ]; then
            FILESBUCKET=$(aws s3 ls $bucket | awk '{print $4}')
            FILESFS=$(ls /mnt/$fs)
            for filebt in $FILESBUCKET; do
                if [[ $FILESFS =~ (' '|^)$filebt(' '|$) ]];
                    then echo 'Arquivo existe no fs!'
                    else aws s3 cp s3://$bucket/$filebt /mnt/$fs/
                fi
            done
            for filefs in $FILESFS; do
                if [[ $FILESBUCKET =~ (' '|^)$filefs(' '|$) ]];
                    then echo 'Arquivo existe no bucket!'
                    else aws s3 cp /mnt/$fs/$filefs s3://$bucket
                fi
            done
        fi
    done
done