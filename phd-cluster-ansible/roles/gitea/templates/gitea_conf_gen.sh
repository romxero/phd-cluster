#!/bin/bash
# This script generates the app.ini file for gitea

MY_GITEA_INTERNAL_TOKEN=$("{{ GITEA_PREFIX_DIR }}/bin/gitea" generate secret INTERNAL_TOKEN)
MY_GITEA_JWT_SECRET=$("{{ GITEA_PREFIX_DIR }}/bin/gitea" generate secret JWT_SECRET)
MY_GITEA_LFS_JWT_SECRET=$("{{ GITEA_PREFIX_DIR }}/bin/gitea" generate secret LFS_JWT_SECRET)

echo "MY_GITEA_INTERNAL_TOKEN: ${MY_GITEA_INTERNAL_TOKEN}" >> "{{ GITEA_PREFIX_DIR }}/data/internal_token.txt"
echo "MY_GITEA_JWT_SECRET: ${MY_GITEA_JWT_SECRET}"
echo "MY_GITEA_LFS_JWT_SECRET: ${MY_GITEA_LFS_JWT_SECRET}"

cat << EOF > "{{ GITEA_PREFIX_DIR }}/custom/conf/app.ini"
APP_NAME = Test
RUN_USER = git
WORK_PATH = "{{ GITEA_PREFIX_DIR }}"
RUN_MODE = prod

[server]
LOCAL_ROOT_URL = http://localhost:{{ GITEA_WEB_SERVING_PORT }}/
SSH_DOMAIN = {{ GITEA_HOSTNAME }}
DOMAIN = {{ GITEA_HOSTNAME }}
HTTP_PORT = {{ GITEA_WEB_SERVING_PORT }}
ROOT_URL = http://{{ GITEA_HOSTNAME }}:{{ GITEA_WEB_SERVING_PORT }}/
APP_DATA_PATH = "{{ GITEA_PREFIX_DIR }}/data"
DISABLE_SSH = true
SSH_PORT = "{{ GITEA_SSH_PORT }}"
LFS_START_SERVER = true
LFS_JWT_SECRET = ${MY_GITEA_LFS_JWT_SECRET}
OFFLINE_MODE = true

[database]
DB_TYPE = sqlite3
HOST = 127.0.0.1:3306
NAME = gitea
USER = gitea
PASSWD =
SCHEMA =
SSL_MODE = disable
PATH = "{{ GITEA_PREFIX_DIR }}/data/gitea.db"
LOG_SQL = false

[repository]
ROOT = "{{ GITEA_PREFIX_DIR }}/data/gitea-repositories"

[lfs]
PATH = "{{ GITEA_PREFIX_DIR }}/data/lfs"

[mailer]
ENABLED = false

[service]
REGISTER_EMAIL_CONFIRM = false
ENABLE_NOTIFY_MAIL = false
DISABLE_REGISTRATION = false
ALLOW_ONLY_EXTERNAL_REGISTRATION = false
ENABLE_CAPTCHA = false
REQUIRE_SIGNIN_VIEW = false
DEFAULT_KEEP_EMAIL_PRIVATE = false
DEFAULT_ALLOW_CREATE_ORGANIZATION = true
DEFAULT_ENABLE_TIMETRACKING = true
NO_REPLY_ADDRESS = noreply.localhost

[openid]
ENABLE_OPENID_SIGNIN = true
ENABLE_OPENID_SIGNUP = true

[cron.update_checker]
ENABLED = false

[session]
PROVIDER = file

[log]
MODE = console
LEVEL = info
ROOT_PATH = "{{ GITEA_PREFIX_DIR }}/log"

[repository.pull-request]
DEFAULT_MERGE_STYLE = merge

[repository.signing]
DEFAULT_TRUST_MODEL = committer

[security]
INSTALL_LOCK = true
INTERNAL_TOKEN = ${MY_GITEA_INTERNAL_TOKEN}
PASSWORD_HASH_ALGO = pbkdf2

[oauth2]
JWT_SECRET = ${MY_GITEA_JWT_SECRET}
EOF