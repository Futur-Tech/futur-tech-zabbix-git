#!/usr/bin/env bash

source "$(dirname "$0")/ft-util/ft_util_inc_var"
source "$(dirname "$0")/ft-util/ft_util_inc_func"
source "$(dirname "$0")/ft-util/ft_util_sudoersd"

app_name="ft-git"

if [ -f /etc/debian_version ]; then # Debian
    echo "
  SETUP SUDOER FILES
------------------------------------------"
    bak_if_exist "/etc/sudoers.d/${app_name}"
    sudoersd_reset_file $app_name zabbix
    sudoersd_addto_file $app_name zabbix "${S_DIR_PATH}/deploy-update.sh"
    sudoersd_addto_file $app_name zabbix "${S_DIR_PATH}/git-all fetch"
    sudoersd_addto_file $app_name zabbix "${S_DIR_PATH}/git-all qstatus"
    show_bak_diff_rm "/etc/sudoers.d/${app_name}"
fi

exit
