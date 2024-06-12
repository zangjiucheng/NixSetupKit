# sleep 20
if [ "$(id -u)" -ne 0 ];
then echo "Please run as root"
    exit
fi
# Mount SMB share
sudo mount -t cifs -o credentials=/home/jiucheng/.smd-credit/RaspiCredit.credit //192.168.2.99/Public_Share /home/jiucheng/raspiShare/
sudo mount -t cifs -o credentials=/home/jiucheng/.smd-credit/RaspiCredit.credit //192.168.2.99/Storage /home/jiucheng/nas/
