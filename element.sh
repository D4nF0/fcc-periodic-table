#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table -t --no-align -c"

ARG_CONTROL() {
  if [[ -z $1 ]]
  then 
    echo "Please provide an element as an argument."
  else 

    if [[ $1 =~ ^[0-9]+$ ]]
    then
      SELECTOR $1 atomic_number
    else 
      if [[ ${#1} -le 2 ]]
      then
        SELECTOR $1 symbol
      elif [[ ${#1} -ge 4 ]]
      then
        SELECTOR $1 name
      else
        if [[ $1 == Tin ]]
        then
          SELECTOR $1 name
        else 
          SELECTOR $1 symbol
        fi
      fi
    fi
    
  fi
}

SELECTOR() {
    echo "$1 $2"
}


ARG_CONTROL $1