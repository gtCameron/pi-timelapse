#!/bin/bash

if [ -z "$1" ]
then
	echo "Please enter bucket name"
else 

	dir=`pwd`

	wget -O- -q http://s3tools.org/repo/deb-all/stable/s3tools.key | sudo apt-key add -
	sudo wget -O/etc/apt/sources.list.d/s3tools.list http://s3tools.org/repo/deb-all/stable/s3tools.list
	sudo apt-get update 

	sudo apt-get install s3cmd fswebcam

	s3cmd --configure

	s3cmd mb s3://$1

	echo $1 > .sitename

	command="./$dir/timelapse.sh"
	job="0,30 * * * * $command"
	cat <(fgrep -i -v "$command" <(crontab -l)) <(echo "$job") | crontab -

fi