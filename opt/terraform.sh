#!/bin/bash

if [ "${APP_NAME}" = "" ]
then
  echo "require variable APP_NAME"
  exit 1
fi

if [ ! -d "${APP_NAME}" ]
then
  echo "APP_NAME is not found"
  exit 1
fi

if [ "${COMMAND_NAME}" != "plan" -a "${COMMAND_NAME}" != "apply" -a "${COMMAND_NAME}" != "destroy" ]
then
  echo "unsupported command ${COMMAND_NAME}"
  exit 1
fi

set -u

## 変数定義
ROOT_DIR=.
TMP_DIR=${ROOT_DIR}/_tmp
APP_NAME_PRE=hands-on-vol

## 一時ディレクトリ作成
mkdir -p ${TMP_DIR}
rm -f ${TMP_DIR}/*

## 一時ディレクトリにtfファイルをcopy
VOL_NUMBER=${APP_NAME: -1}
while [ ${VOL_NUMBER} -gt 0 ]
do
  cp -p ${APP_NAME_PRE}${VOL_NUMBER}/tf/* ${TMP_DIR}
  VOL_NUMBER=$(expr $VOL_NUMBER - 1)
done

cd ${TMP_DIR}

## terrform init
terraform init

## 削除リソースの確認
if [ "${COMMAND_NAME}" = "destroy" ]
then
  terraform show
  echo "-----------------------------------"
  echo "Delete the above resources? [Y/n]"
  echo "-----------------------------------"
  read ANSWER

  case $ANSWER in
    "" | "Y" | "y" | "yes" | "Yes" | "YES" ) 
      exit 0 ;;
    * )
      exit 1 ;;
  esac
fi

## terrform plan or apply
terraform ${COMMAND_NAME} \
  -state=./terraform.tfstate \
  -refresh=true \

## 元のディレクトリに戻る
cd -

#rm -rf ${TMP_DIR}