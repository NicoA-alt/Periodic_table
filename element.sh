PSQL="psql --username=freecodecamp --dbname=periodic_table -t --tuples-only -c"
#Si no hay parametros
if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
#Comprobar si es un numero
 if [[ $1 =~ ^[1-9]+$ ]]
 #En caso de que sea un numero
 then
  ELEMENT=$($PSQL "select atomic_number,name,symbol,type,atomic_mass,melting_point_celsius,boiling_point_celsius from elements full join properties using(atomic_number) full join types using(type_id) where atomic_number=$1")
 else
 #En caso de que no sea un numero
  ELEMENT=$($PSQL "select atomic_number,name,symbol,type,atomic_mass,melting_point_celsius,boiling_point_celsius from elements full join properties using(atomic_number) full join types using(type_id) where symbol='$1' or name='$1'")
 fi
 #No se encontro el elemnto
 if [[ -z $ELEMENT ]]
 then
  echo "I could not find that element in the database."
 #Se encontro el elemento
 else
  echo $ELEMENT | while IFS=' | ' read ATOMIC_NUMBER NAME SYMBOL TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT
  do
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  done
 fi
fi