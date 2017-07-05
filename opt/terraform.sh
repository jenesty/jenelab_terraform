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
TF_DIR=./${APP_NAME}/tf

## 一時ディレクトリ作成
mkdir -p ${TMP_DIR}
#rm -f ${TMP_DIR}/*

## 一時ディレクトリにtfファイルをcopy
cp -p ${TF_DIR}/*tf ${TMP_DIR}
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
      echo "Run terraform destroy";;
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