source common.sh

print_head "Configure NodeJS Repo"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$(log_file)
status_check $?

print_head "install NodeJS"
yum install nodejs -y &>>$(log_file)
status_check $?

print_head "create Roboshop user"
id roboshop &>>$(log_file)
if [ $? -ne 0 ], then
  useradd roboshop &>>$(log_file)
f1
status_check $?

print_head "Create Application Directory"
if [ f -d /app ], then
mkdir /app &>>$(log_file)
status_check $?

print_head "Delete Old content"
rm -rf /app/* &>>$(log_file)
status_check $?

print_head "Downloading App Content"
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>$(log_file)
cd /app
status_check $?

print_head "extracting App Content"
unzip /tmp/catalogue.zip &>>$(log_file)
status_check $?

print_head "Installing nodeJS Dependencies"
npm install &>>$(log_file)
status_check $?

print_head "Copy systenD service File"
cp $[code_dir]/configs/catalogue.service /etc/systemd/system/catalogue.servive &>>$(log_file)
status_check $?

print_head "Reload system"
systemctl daemon-reload &>>$(log_file)
status_check $?

print_head "Enable catalogue Service"
systemctl enable catalogue &>>$(log_file)
status_check $?

print_head "Start Catalogue Service"
systemctl start catalogue &>>$(log_file)
status_check $?

print_head "Copy mongodb repo File"
cp $ [code_dir]/configs/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>$(log_file)
status_check $?

print_head "Install mongo Client"
yum install mongodb-org-shell -y &>>$(log_file)
status_check $?

print_head "load schema"
mongo --host mongodb.navanidevops.online </app/schema/catalogue.js &>>$(log_file)
status_check $?