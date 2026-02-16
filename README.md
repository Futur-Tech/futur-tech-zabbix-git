# Futur-Tech Zabbix Git Repo Monitoring

Zabbix module to monitor and maintain multiple local Git repositories from one host.

## Expected Layout

`git-all` scans repositories in the parent folder of this project.

Example:
```text
/usr/local/src/
  futur-tech-zabbix-git/
  repo-a/
  repo-b/
```

Only directories containing `.git` are processed.

## Installation

1. Clone this repository next to the repositories you want to monitor.
2. Run the deployment script:

```bash
cd /usr/local/src/futur-tech-zabbix-git
sudo ./deploy-update.sh -b main
```

`deploy-update.sh` behavior:
- checks out the target branch (`-b`),
- fetches updates,
- self-updates and re-executes if needed,
- then runs `./deploy.sh`.

`deploy.sh` installs:
- Zabbix include file:
  - `/etc/zabbix/zabbix_agent2.d/ft-git.conf`, or
  - `/etc/zabbix/zabbix_agentd.conf.d/ft-git.conf`
- sudoers rules in `/etc/sudoers.d/ft-git` for required commands.
- delayed Zabbix agent restart (`systemctl restart zabbix-agent*` via `at`).

## `git-all` Usage

```bash
./git-all [option] [branch]
```

Options:
- `status`: fetch all repos first, then print status for each repo.
- `qstatus`: status only (no pre-fetch).
- `fetch`: fetch all repos, then report which ones need merging.
- `qfetch`: quiet fetch only.
- `pull`: run `git pull` on each repo.
- `merge`: run `git merge origin` when updates are available.
- `deploy-update <branch>`: run `./deploy-update.sh -b <branch>` in each clean repo that is behind origin.

Examples:
```bash
./git-all qstatus
./git-all fetch
./git-all deploy-update main
```
