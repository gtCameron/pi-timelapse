#!/bin/bash

date=$(date +'%Y-%m-%d_%T')
fname=capture_$date.jpg

fswebcam -r 1280x720 --no-banner $fname

s3cmd put --acl-public --guess-mime-type $fname s3://$bucketname/$fname

rm $fname