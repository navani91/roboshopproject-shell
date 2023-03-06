source common.sh

print_head "installing nginx"
yum install nginx -y &>>$(log_file)

print_head "Removing old content"
rm -rf /usr/share/nginx/html/* &>>$(log_file)
print_head "dOWNLOADING frontend content"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>$(log_file)

print_head"Extracting Downloaded Frontend"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>$(log_file)

print_head "Copying Nginx config for Roboshop"
cp $(code_dir)/configs/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>$(log_file)

print_head "ENABLING NGINX"
systemctl enable nginx &>>$(log_file)

print_head "sTARTING NGINX"
systemctl restart nginx &>>$(log_file)