#!/bin/bash
BASE_URL=https://raw.githubusercontent.com/sidelab-development/azure_infra_template/master/samples

CHOICE=default

INFRA_DIR='./app_infra'

WHITE="\033[0;37m";
BLACK="\033[1;30m";
GREEN="\033[0;32m";
GREEN_BOLD="\033[1;32m";
BLUE="\033[0;34m"
RESET="\033[0m";
RED="\033[1;31m";

flag_error() {
  echo "Use only allowed flags: -r (resource), -n (name), -f (filename)"
  exit 1;
}

terraform_logo() {
  echo -e "${BLUE}⣷⣦⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⣿⣿⣿⣿⣶⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⣀
⣿⣿⣿⣿⣿⢸⣿⣷⣦⣀⠀⢀⣠⣶⣿⣿
⠀⠙⠛⢿⣿⢸⣿⣿⣿⣿⡇⣿⣿⣿⣿⣿
⠀⠀⠀⠀⠈⢘⢻⣿⣿⣿⡇⣿⣿⣿⡿⠟
⠀⠀⠀⠀⠀⢸⣿⣦⣍⡻⠇⠿⠛⠁⠀⠀
⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠸⢿⣿⣿⣿⡇⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠈⠙⠿⡇⠀⠀⠀⠀⠀${RESET}"
}

choose_resource() {
  case $1 in
    ("service_bus") CHOICE="service_bus";;
    ("servicebus") CHOICE="service_bus";;
    ("sb") CHOICE="service_bus";;

    ("cosmos_db") CHOICE="cosmos_db";;
    ("cosmosdb") CHOICE="cosmos_db";;
    ("cosmos") CHOICE="cosmos_db";;

    ("function_app") CHOICE="function_app";;
    ("functionapp") CHOICE="function_app";;
    ("func") CHOICE="function_app";;

    ("key_vault") CHOICE="keyvault";;
    ("keyvault") CHOICE="keyvault";;
    ("kv") CHOICE="keyvault";;

    ("cognitive_services") CHOICE="cognitive_services";;
    ("cognitiveservices") CHOICE="cognitive_services";;
    ("cgs") CHOICE="cognitive_services";;
  
    ("sql_server") CHOICE="sql_server";;
    ("sqlserver") CHOICE="sql_server";;
    ("sqls") CHOICE="sql_server";;

    ("storage_account") CHOICE="storage_account";;
    ("storageaccount") CHOICE="storage_account";;
    ("sa") CHOICE="storage_account";;

    ("storage_account_website") CHOICE="storage_acc_for_website";;
    ("sa_web") CHOICE="storage_acc_for_website";;
    ("saw") CHOICE="storage_acc_for_website";;

    (*) CHOICE="error";;
  esac
}

# READING PARAMETERS (resource, name and filename)
resource=default name=sample filename=default
while getopts ":n:r:f:" o; do
  case $o in
    (r) resource=$OPTARG;;
    (n) name=$OPTARG;;
    (f) filename=$OPTARG;;
    (*) flag_error
  esac
done

# SET VAR 'CHOICE' WITH RESOURCE NAME
choose_resource $resource

# IF FILENAME HAS NOT PROVIDED, USE RESOURCE AS FILENAME
if [[ "${filename}" == "default" ]];
then
  filename="${CHOICE}"
fi;

# CHECK IF RESOURCE IS VALID
if [[ "${CHOICE}" == "error" ]];
then
  echo -e "${RED}> Error: ${CHOICE} not exists in available sample resources${RESET}"; break;
else
  echo -e "${WHITE}> Adding resource file for: ${GREEN_BOLD}${CHOICE}${WHITE}${RESET}"

  # CREATE USEFUL VARIABLES
  FILE_NAME=$filename
  FILE_PATH="${INFRA_DIR}/${FILE_NAME}.tf"

  # CHECK IF ALREADY EXIST FILE WITH SAME NAME
  while test -f $FILE_PATH; do
    FILE_NAME+="_copy"
    FILE_PATH="${INFRA_DIR}/${FILE_NAME}.tf"
  done


  # DOWNLOAD FILE CONTENT FROM GITHUB
  echo -e "${WHITE}> Downloading content...${RESET}"
  curl -s "${BASE_URL}/${CHOICE}.tf" >> $FILE_PATH;

  if [[ "${CHOICE}" == "function_app" ]];
  then
    # CHECK IF ALREADY EXIST FILE WITH SAME NAME
    while ! test -f "${INFRA_DIR}/app_insights.tf"; do
      curl -s "${BASE_URL}/app_insights.tf" >> "${INFRA_DIR}/app_insights.tf";
    done
  fi;

  # REPLACE 'sample' FOR PROVDED NAME IN ARG '-n'
  sed -i "s/sample/$name/g" $FILE_PATH

  terraform_logo; # SHOW TERRAFORM LOGO

  # OUTPUT RESULT
  echo -e "${BLACK}Resource:${RESET} ${CHOICE}"
  if [ "$name" != "sample" ]
  then
    echo -e "${BLACK}Name:${RESET} ${name}";
  fi;
  echo -e "${WHITE}File created in ${GREEN}${FILE_PATH}${RESET}";

fi;
