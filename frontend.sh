echo /e"/e[35minstalling nginx/e[0m"
yum install nginx -y

echo /e"/e[35mRemoving old content/e[0m"
rm -rf /usr/share/nginx/html/*

echo /e"/e[35mdOWNLOADING frontend content/e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

echo /e"/e[35mExtracting Downloaded Frontend/e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

echo /e"/e[35mCopying Nginx config for Roboshop/e[0m"
cp configs/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf

echo /e"/e[35meNABLING NGINX/e[0m"
systemctl enable nginx

echo /e"/e[35msTARTING NGINX/e[0m"
systemctl restart nginx


