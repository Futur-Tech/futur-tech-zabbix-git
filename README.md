# Futur-Tech Zabbix Git Repo Monitoring

You need to deploy this repo near other repos

In Zabbix server you can setup this item key

system.run[cd "{$GIT_SRC}/futur-tech-zabbix-git" ; sudo ./git-all status | grep -vE "Waiting for all repos to report: done|No changes$"]

If not empty then it means repository need update.