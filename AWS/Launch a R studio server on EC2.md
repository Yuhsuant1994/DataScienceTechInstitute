## Step 1: launch an instance 
* Configuration with advance user data script
```
#!/bin/bash
	#Update the package manager
	#Yum in this case as it is ran on Amazon Linux
	sudo yum update -y
	

	#Install R
	sudo yum install -y R
	

	#Install RStudio-Server
	#https://www.rstudio.com/products/rstudio/download-server/
	wget https://download2.rstudio.org/rstudio-server-rhel-1.1.383-x86_64.rpm
	sudo yum install -y --nogpgcheck rstudio-server-rhel-1.1.383-x86_64.rpm
	sudo rm rstudio-server-rhel-1.1.383-x86_64.rpm
	

	#Install shiny and shiny-server
	sudo R -e "install.packages('shiny', repos='http://cran.rstudio.com/')"
	wget https://download3.rstudio.org/centos5.9/x86_64/shiny-server-1.5.5.872-rh5-x86_64.rpm
	sudo yum install -y --nogpgcheck shiny-server-1.5.5.872-rh5-x86_64.rpm
	sudo rm shiny-server-1.5.5.872-rh5-x86_64.rpm
	

	#add user(s)
	sudo useradd username
	echo username:password | sudo chpasswd
```
* Security Group add “custom TCP” with Port Range 8787

## Step 2: reach RStudio from web browser

* Go to web browser `<your public ip>:8787` Should led you to RStudio. 
* Now with the account we’ve created in the script we are able to login

```
Username: username
Password: password
```

## Step 3: 

In the instance there's a file that can monitor everything happen in the user data.

* /var/log/cloud-init-output.log 

`cat /var/log/cloud-init-output.log`

Reference: https://github.com/leodsti/AWS_Tutorials/tree/master/Install%20R%20Server
