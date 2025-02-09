# sleep 20
if [ "$(id -u)" -ne 0 ];
then echo "Please run as root"
    exit
fi
# Mount SMB share
sudo mount -t cifs -o credentials=/home/jiucheng/.smd-credit/UWCredit.credit //smb-files.student.cs.uwaterloo.ca/j7zang /home/jiucheng/UWShare

