#!/usr/bin/env bash

source "$(dirname "$0")/ft-util/ft_util_inc_var"

sudoers_etc="/etc/sudoers.d/ft-git"

echo "
  SETUP SUDOER FILES
------------------------------------------"

$S_LOG -d $S_NAME -d "$sudoers_etc" "==============================="

if [ -f /etc/debian_version ]; then # Debian
    echo "Defaults:zabbix !requiretty" | sudo EDITOR='tee' visudo --file=$sudoers_etc &>/dev/null
    echo "zabbix ALL=(ALL) NOPASSWD:/usr/bin/git" | sudo EDITOR='tee -a' visudo --file=$sudoers_etc &>/dev/null
    echo "zabbix ALL=(ALL) NOPASSWD:${S_DIR_PATH}/deploy-update.sh" | sudo EDITOR='tee -a' visudo --file=$sudoers_etc &>/dev/null
    echo "zabbix ALL=(ALL) NOPASSWD:${S_DIR_PATH}/git-all *" | sudo EDITOR='tee -a' visudo --file=$sudoers_etc &>/dev/null

elif uname --all | grep synology >/dev/null; then # Synology DSM
    echo "Defaults:zabbix !requiretty" >"${sudoers_etc}"
    echo "zabbix ALL=(ALL) NOPASSWD:/bin/git" >>"${sudoers_etc}"
    echo "zabbix ALL=(ALL) NOPASSWD:${S_DIR_PATH}/deploy-update.sh" >>"${sudoers_etc}"
    echo "zabbix ALL=(ALL) NOPASSWD:${S_DIR_PATH}/git-all *" >>"${sudoers_etc}"
    chmod 0440 "$sudoers_etc"
fi

cat $sudoers_etc | $S_LOG -d "$S_NAME" -d "$sudoers_etc" -i
$S_LOG -d $S_NAME -d "$sudoers_etc" "==============================="

$S_LOG -d "$S_NAME" "End $S_NAME"

exit
