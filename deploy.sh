#!/usr/bin/env bash

source "$(dirname "$0")/ft-util/ft_util_inc_var"

$S_LOG -d $S_NAME "Start $S_NAME $*"

echo "
  CHECK OS
------------------------------------------"

if [ -d "/etc/zabbix" ]
then
    OS="Linux"
    
elif [ -d "/usr/local/zabbix/etc/" ]
then
    OS="Synology"
    
else
    $S_LOG -s crit -d $S_NAME "Sorry Zabbix conf folder could not be found. Exit."
    exit 1
fi

SUDOERS_ETC="/etc/sudoers.d/ft-git"

$S_LOG -d "$S_NAME" "The script will run for $OS" 


echo "
  SETUP SUDOER FILES
------------------------------------------"

$S_LOG -d $S_NAME -d "$SUDOERS_ETC" "==============================="

case $OS in
    Linux)
        echo "Defaults:zabbix !requiretty" | sudo EDITOR='tee' visudo --file=$SUDOERS_ETC &>/dev/null
        echo "zabbix ALL=(ALL) NOPASSWD:/usr/bin/git" | sudo EDITOR='tee -a' visudo --file=$SUDOERS_ETC &>/dev/null
        echo "zabbix ALL=(ALL) NOPASSWD:${S_DIR_PATH}/deploy-update.sh" | sudo EDITOR='tee -a' visudo --file=$SUDOERS_ETC &>/dev/null
        echo "zabbix ALL=(ALL) NOPASSWD:${S_DIR_PATH}/git-all status" | sudo EDITOR='tee -a' visudo --file=$SUDOERS_ETC &>/dev/null
        echo "zabbix ALL=(ALL) NOPASSWD:${S_DIR_PATH}/git-all deploy-update main" | sudo EDITOR='tee -a' visudo --file=$SUDOERS_ETC &>/dev/null
        ;;
    Synology)
        echo "Defaults:zabbixagent !requiretty" > "${SUDOERS_ETC}"
        echo "zabbixagent ALL=(ALL) NOPASSWD:/bin/git" >> "${SUDOERS_ETC}"
        echo "zabbixagent ALL=(ALL) NOPASSWD:${S_DIR_PATH}/deploy-update.sh" >> "${SUDOERS_ETC}"
        echo "zabbixagent ALL=(ALL) NOPASSWD:${S_DIR_PATH}/git-all status" >> "${SUDOERS_ETC}"
        echo "zabbixagent ALL=(ALL) NOPASSWD:${S_DIR_PATH}/git-all deploy-update main" >> "${SUDOERS_ETC}"
        chmod 0440 "$SUDOERS_ETC"
        ;;
esac

cat $SUDOERS_ETC | $S_LOG -d "$S_NAME" -d "$SUDOERS_ETC" -i 

$S_LOG -d $S_NAME -d "$SUDOERS_ETC" "==============================="

$S_LOG -d "$S_NAME" "End $S_NAME"

exit