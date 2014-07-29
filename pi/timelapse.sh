#!/bin/bash

date=$(date +'%Y-%m-%d_%T')
fname=capture_$date.jpg
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
bucketname=$(<$dir/.sitename)

raspistill -vf -hf -o $fname

s3cmd put --acl-public --guess-mime-type $fname s3://$bucketname/$fname
s3cmd put --acl-public --guess-mime-type $fname s3://$bucketname/latest.jpg

rm $fname