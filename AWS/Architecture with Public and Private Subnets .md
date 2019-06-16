Reference link: https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Scenario2.html

# Introduction
This exercise is to create a simple architecture on AWS, using 1 VPC with public and private subnet.

We want to make the instance (#3) in the private subnet able to reach to the internet on google.com for example.

## Step 1: Create Key Pair 
* In EC2: Create EC2 Key pair for the NAT instance to use.

<img src="image/AWSimg1.png" width=600>

<img src="image/AWSimg2.png" width=600>

## Step 2: launch VPC
* In VPC: Using VPC Wizard
<img src="image/AWSimg3.png" width=600>

* Select VPC with public and private subnet
<img src="image/AWSimg4.png" width=600>

* Specify the NAT instance with the pre-created key pair
<img src="image/AWSimg5.png" width=600>

* Now in **EC2** we can see NAT instance sucessfully created
<img src="image/AWSimg6.png" width=600>



