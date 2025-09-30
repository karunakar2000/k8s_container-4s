#!/bin/bash

AMI_ID="ami-09c813fb71547fc4f"
SG_ID="sg-0ceb0b5650cb41dcc"
ZONE_ID="Z03906525JXX97QJY8QE"
DOMAIN_NAME="myawsb60.xyz"

for instance in $@; do
	INSTANCE_ID=$(aws ec2 run-instances --image-id $AMI_ID --instance-type t3.micro --security-group-ids $SG_ID --subnet-id subnet-04a48f12db05e7448 --region us-east-1 --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" --query 'Instances[0].InstanceId' --output text)

	# Get Private IP
	if [ $instance != "frontend" ]; then
		IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[0].Instances[0].PrivateIpAddress' --output text)
		RECORD_NAME="$instance.$DOMAIN_NAME"
	else
		IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)
		RECORD_NAME="$DOMAIN_NAME"
	fi
	echo "$instance: $IP"

	aws route53 change-resource-record-sets \
		--hosted-zone-id $ZONE_ID \
		--change-batch '
  	{
    	"Comment": "creating a record sets"
    	,"Changes": [{
      	"Action"              : "CREATE"
      	,"ResourceRecordSet"  : {
        	"Name"             : "'$RECORD_NAME'"
        	,"Type"            : "A"
        	,"TTL"             : 1
        	,"ResourceRecords" : [{
            	"Value"        : "'$IP'"
        }]
      }
    }]
  }
  '
done
