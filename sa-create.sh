#!/bin/bash

#Создание сервис-аккаунта
yc iam service-account create --name sa

#Присваиваем переменные
sa_id="$(yc iam service-account list | grep 'sa' | awk '{print $2}')"
folder_id="$(yc config list | grep 'folder-id' | awk '{print $2}')"
cloud_id="$(yc config list | grep 'cloud-id' | awk '{print $2}')"

#Добавление роли сервис аккаунту
yc resource-manager folder add-access-binding $folder_id --role editor --subject serviceAccount:$sa_id


#Создание iam-ключей статический ключ доступа и ключа для доступа к облаку с записью в файлы
yc iam access-key create --service-account-id $sa_id --format json > ./access-key.json
yc iam key create --service-account-id $sa_id --folder-id $folder_id --output key.json

#Создание и конфигурирование профиля
yc config profile create sa
yc config set service-account-key key.json
yc config set cloud-id $cloud_id
yc config set folder-id $folder_id

#Экспорт необходимых переменнных окружения
export YC_CLOUD_ID="$(yc config get cloud-id)"
export YC_FOLDER_ID="$(yc config get folder-id)"
export AWS_ACCESS_KEY="$(grep 'key_id' ./access-key.json | awk '{print $2}' | tr -d \")"
export AWS_SECRET_KEY="$(grep 'secret' ./access-key.json | awk '{print $2}' | tr -d \")"
export TF_VAR_account_id=$sa_id
export TF_VAR_folder_id="$(yc config get cloud-id)"
export TF_VAR_cloud_id="$(yc config get folder-id)"