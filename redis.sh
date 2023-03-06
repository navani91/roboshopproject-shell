sourse commom.sh

print_head "Installing Redis repo file"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm  y &>>$(log_file)
status_check $?

print_head "Enable 6.2 redis repo"
dnf module enable redis:remi-6.2 -y &>>$(log_file)
status_check $?

print_head "Install redis"
yum install redis -y &>>$(log_file)
status_check $?

print_head "Update redis listen Address"
sed -1 -e 's/127.0.0.1 to 0.0.0.0/' /etc/redis.conf & /etc/redis/redis.conf &>>$(log_file)
status_check $?

print_head "enable redis"
systemctl enable redis
status_check $?

print_head "Start redis"
systemctl start redis
status_check $?