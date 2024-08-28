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
  if [[ $2 == atomic_number ]]
  then

    CONTROL=$($PSQL "SELECT * FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE $2=$1;")
    if [[ -z $CONTROL ]]
    then
      echo "I could not find that element in the database."
    else 
      ($PSQL "SELECT * FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE $2=$1;") | while IFS="|" read TYPE_ID ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE
      do
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
      done
    fi

  else 

    CONTROL=$($PSQL "SELECT * FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE $2='$1';")
    if [[ -z $CONTROL ]]
    then
      echo "I could not find that element in the database."
    else 
      ($PSQL "SELECT * FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE $2='$1';") | while IFS="|" read TYPE_ID ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE
      do
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."  
      done
    fi

  fi

}


ARG_CONTROL $1