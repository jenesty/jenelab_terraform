@echo off

set APP_NAME=%1
set COMMAND_NAME=%2

if NOT DEFINED APP_NAME (
    echo require variable APP_NAME
    exit /b 0
)

if NOT EXIST ".\%APP_NAME%\" (
    echo ".\%APP_NAME%\" is not found
    exit /b 0
)

if NOT "%COMMAND_NAME%" == "plan" if NOT "%COMMAND_NAME%" == "apply" if NOT "%COMMAND_NAME%" == "destroy" (
    echo unsupported command %COMMAND_NAME%
    exit /b 0
)

rem ## 変数定義
set ROOT_DIR=%cd%
set TMP_DIR=%ROOT_DIR%\_tmp
set COMMON_VARS=%ROOT_DIR%\common_vars\vars.tf

rem ## 一時ディレクトリ作成
mkdir %TMP_DIR%
del /Q %TMP_DIR%\*

rem ## 一時ディレクトリにtfファイルをcopy
copy %COMMON_VARS% %TMP_DIR%
copy %APP_NAME%\tf\* %TMP_DIR%

cd %TMP_DIR%

rem ## terrform init
echo "### terraform init"
terraform init

if %ERRORLEVEL% NEQ 0 goto FAILURE

:SUCCESS
rem ## 削除リソースの確認
if "%COMMAND_NAME%" == "destroy" (
    terraform show
    rem ### 変数初期化
    set ANSWER=
    rem ### 入力要求
    set /P ANSWER="Delete the above resources? [Y/n]: "

    if NOT DEFINED ANSWER ( goto ANSWER_YES )
    if "%ANSWER%" == "Y" ( goto ANSWER_YES )
    if "%ANSWER%" == "y" ( goto ANSWER_YES )
    if "%ANSWER%" == "yes" ( goto ANSWER_YES )
    if "%ANSWER%" == "Yes" ( goto ANSWER_YES )
    if "%ANSWER%" == "YES" ( goto ANSWER_YES )

    :ANSWER_NO
    rem ## 元のディレクトリに戻る
    cd %ROOT_DIR%
    rmdir /S /Q %TMP_DIR%

    exit /b 0
    
    :ANSWER_YES
    rem ## terrform plan or apply
    echo "### terraform %COMMAND_NAME% -state=.\.terraform\terraform.tfstate -refresh=true"
    terraform %COMMAND_NAME% -state=.\.terraform\terraform.tfstate -refresh=true

    rem ## 元のディレクトリに戻る
    cd %ROOT_DIR%
    rmdir /S /Q %TMP_DIR%

    exit /b 0

) else (
    rem ## terrform plan or apply
    echo "### terraform %COMMAND_NAME% -state=.\.terraform\terraform.tfstate -refresh=true"
    terraform %COMMAND_NAME% -state=.\.terraform\terraform.tfstate -refresh=true

    rem ## 元のディレクトリに戻る
    cd %ROOT_DIR%
    rmdir /S /Q %TMP_DIR%

    exit /b 0
)

:FAILURE
echo ### ERROR STOP ###
cd %ROOT_DIR%
rmdir /S /Q %TMP_DIR%

exit /b 0
