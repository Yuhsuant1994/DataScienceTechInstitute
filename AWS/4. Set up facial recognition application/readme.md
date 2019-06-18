# Introduction:

We are going to build a small web application for facial recognition using AWS. 

## Step 1: Download essential file in documents folder

* DSTIFamily.html
* package.json
* server.js
* webcam.min.js 

## Step 2: build EC2 instances

We will build 2 instance (Linux) on AWS EC2: Web server (front end) and app server(backend). 
1. Web server instance: apache
* Add security group `Ports=80`, `Protocal= tpc`, `Source= ::/0` 
* Open auto assign public IP
