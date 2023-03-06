code_dir=$(pwd)
loh_file=/tmp/roboshop.log
rm -f $(log_file)

print_head() {
  echo -e "/e[35m$1/e[0m"
}

status_check()[
if [ $? =eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
  echo "Read thr log file $(log_file) for more information about error"
exit 1
]
