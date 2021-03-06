# Ansible плейбук для запуска GitLab CI

Ansible плейбук для конфигурации инсталляции GitLab CI в AWS

## Динамический инвентарь

При создании EC2 инстансов использутся теги для разделения окружений, приложений и ролей серверов:

```
  tags = {
    <...>
    Environment = "dev"
    Application = "gitlab"
    Role        = "app"
    <...>
  }
```

Во время сбора инвентаря, ansible формирует группы для указанных тегов, что позволяет разделять разработку и
основной запуск, а также разделить plays в основном плейбуке.

## Группы GitLab приложения

Серверы разбиты на три группы функциональных ролей, требующих выделенных ansible ролей - app, gitaly, runner.
Основной плейбук gitlab.yml разбит на три плея, соответственно.

## Параметры подключения через bastion-хост

Работа с серверами EC2 ведется через bastion-сервер. Серверы приложения находятся в "приватных" сетях,
без доступа извне. Параметры подключения ansible через bastion-хост указаны в файле групповых переменных
для всех хостов (group_vars/all.yml, extra-vars требуются по причине динамического получения
публичного адреса bastion-хоста).

## Ansible Roles
Код ansible вынесен из плейбука в соответствующие ansible-роли для конфигурации функциональных ролей приложения.
Код ansible-ролей находится в вышележащих репозиториях и их установка выполняется с помощью ansible-galaxy и 
их список указан в requirements.yml.

Пример запуска плейбука:

```
ansible-playbook gitlab.yml --limit gitaly:&prod

PLAY [Configure app servers] *************************************************************************************
skipping: no hosts matched

PLAY [Configure gitaly servers] **********************************************************************************

TASK [ping] ******************************************************************************************************
ok: [gitlab-gitaly-prod-0]
ok: [gitlab-gitaly-prod-1]

PLAY [Configure runner servers] **********************************************************************************
skipping: no hosts matched

PLAY RECAP *******************************************************************************************************
gitlab-gitaly-prod-0       : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
gitlab-gitaly-prod-1       : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```