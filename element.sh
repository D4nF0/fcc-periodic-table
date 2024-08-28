#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table -t --no-align -c"

ARG_CONTROL() {
  if [[ -z $1 ]]
  then 
    echo "Please provide an element as an argument."
  else 

    echo "finish"

  fi
}


ARG_CONTROL $1