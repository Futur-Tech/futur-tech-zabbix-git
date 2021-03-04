# Futur-Tech Zabbix Git Repo Monitoring

You need to deploy this repo near other repos

In Zabbix server you can setup this item key

system.run[cd "{$GIT_SRC}/futur-tech-zabbix-git" ; sudo ./git-all status | grep -vE "Waiting for all repos to report: done|No changes$"]

If not empty then it means repository need update.

# git-all script

    git-all [option]
    Options:
        status: Checks all the git repos in git folder
        qstatus: Checks all the git repos in git folder (no fetch)
        pull: Pulls all repos in the folder
        fetch: Fetches all repos in the folder
        qfetch: Fetches all repos in the folder (somewhat) quietly
        merge: Merges all repos in the folder (origin)
        deploy-update: run ".deploy-update -b $2 on each repository
