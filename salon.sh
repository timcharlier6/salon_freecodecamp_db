#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

MAIN_MENU(){
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  echo "How may I help you?" 
  SERVICES=$($PSQL "SELECT * FROM services ORDER BY service_id")
  echo "$SERVICES" | while read SERVICE_ID BAR NAME_SERVICE
  do 
    echo "$SERVICE_ID) $NAME_SERVICE"
  done
  read SERVICE_ID_SELECTED

  case $SERVICE_ID_SELECTED in
    1) CLEANING_MENU ;;
    2) MARKET_MENU ;;
    3) TECNOLOGY_MENU ;;
    *) MAIN_MENU "Please enter a valid option." ;;
  esac
}

CLEANING_MENU(){
  SERVICE=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
  echo -e "\nPlease ente your phone number:"
  read CUSTOMER_PHONE
  CUSTOMER_EXIST=$($PSQL "SELECT * FROM customers WHERE phone='$CUSTOMER_PHONE'")
  if [[ -z $CUSTOMER_EXIST ]]
  then
    echo -e "\nWhat's your name:"
    read CUSTOMER_NAME
    INSERT_CUSTOMER=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
  fi
  echo -e "\nWhat time do you want the appointment:"
  read SERVICE_TIME
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
  INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
  echo -e "\nI have put you down for a $(echo $SERVICE | sed -r 's/^ *| *$//g') at $SERVICE_TIME, $(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//g')."
}



MARKET_MENU(){
  SERVICE=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
  echo -e "\nPlease ente your phone number:"
  read CUSTOMER_PHONE
  CUSTOMER_EXIST=$($PSQL "SELECT * FROM customers WHERE phone='$CUSTOMER_PHONE'")
  if [[ -z $CUSTOMER_EXIST ]]
  then
    echo -e "\nWhat's your name:"
    read CUSTOMER_NAME
    INSERT_CUSTOMER=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
  fi
  echo -e "\nWhat time do you want the appointment:"
  read SERVICE_TIME
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
  INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
  echo -e "\nI have put you down for a $(echo $SERVICE | sed -r 's/^ *| *$//g') at $SERVICE_TIME, $(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//g')."
}

TECNOLOGY_MENU(){
  SERVICE=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
  echo -e "\nPlease ente your phone number:"
  read CUSTOMER_PHONE
  CUSTOMER_EXIST=$($PSQL "SELECT * FROM customers WHERE phone='$CUSTOMER_PHONE'")
  if [[ -z $CUSTOMER_EXIST ]]
  then
    echo -e "\nWhat's your name:"
    read CUSTOMER_NAME
    INSERT_CUSTOMER=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
  fi
  echo -e "\nWhat time do you want the appointment:"
  read SERVICE_TIME
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
  INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
  echo -e "\nI have put you down for a $(echo $SERVICE | sed -r 's/^ *| *$//g') at $SERVICE_TIME, $(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//g')."
}

MAIN_MENU
