source common.sh

print_head "setup mongodb repository"
cp configs/mongodb.repo /etc/yum.repos.d/mongo.repo &>>$(log_file)

print_head "install mongodb"
yum install mongodb-org -y &>>$(log_file)

print_head"update mongodb listen address"
sed -l -e/'127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>$(log_file)

print_head "enable mongodb"
systemctl enable mongod &>>$(log_file)

print_head "start monodb service"
systemctl restart mongod &>>$(log_file)





