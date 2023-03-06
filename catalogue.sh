source common.sh

print_head "Configure NodeJS Repo"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$(log_file)

print_head "install NodeJS"
yum install nodejs -y &>>$(log_file)

print_head "create Roboshop user"
useradd roboshop &>>$(log_file)

print_head "Create Application Directory"
mkdir /app &>>$(log_file)

print_head "Delete Old content"
rm -rf /app/* &>>$(log_file)

print_head "Downloading App Content"
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>$(log_file)
cd /app

print_head "extracting App Content"
unzip /tmp/catalogue.zip &>>$(log_file)

print_head "Installing nodeJS Dependencies"
npm install &>>$(log_file)

print_head "Copy systenD service File"
cd configs/catalogue.service /etc/systemd/system/catalogue.servive &>>$(log_file)

print_head "Reload system"
systemctl daemon-reload &>>$(log_file)

print_head "Enable catalogue Service"
systemctl enable catalogue &>>$(log_file)

print_head "Start Catalogue Service"
systemctl start catalogue &>>$(log_file)

print_head "Copy mongodb repo File"
cp configs/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>$(log_file)

print_head "Install mongo Client"
yum install mongodb-org-shell -y &>>$(log_file)

print_head "load schema"
mongo --host mongodb.navanidevops.online </app/schema/catalogue.js &>>$(log_file)