#!/bin/bash

# Internal Field Separator (IFS) that is used for word splitting 
previIFS=IFS # Guardem el valor del $IFS
# IFS personalizat, per poder delimitar els camps correctament
IFS="`echo -e "\t\n\r\f"`"

UsuariMySQL=root # Usuari de Mysql
PasswordMySQL=daw12019 #Password Mysql
ServidorMySQL="localhost"

# Declarem la variable com array, no es iprescindible, pero és més estricte
declare -a consultaAFer

# Si no ens faciliten un codi de pel·licula mostrem la 1a peli
if [ $# = 0 ]; then
  codi_peli=1
else
  codi_peli=$1
fi

# Muntem la consulta (especificar el joc de caracters determinado, com
# UTF8, ens estalviarà sorpreses.

# mysql> SELECT PELIS.titol_peli, ACT_PELI.papel, ACT.nom_actor FROM PELLICULES PELIS INNER JOIN ACTORS_PELLICULES ACT_PELI INNER JOIN ACTORS ACT ON PELIS.id_peli=ACT_PELI.id_peli AND ACT_PELI.id_actor=ACT.id_actor WHERE PELIS.id_peli=1;
# +-------------+-------------------------+--------------+
# | titol_peli  | papel                   | nom_actor    |
# +-------------+-------------------------+--------------+
# | La busqueda | Benjamin Franklin Gates | Nicolas Cage |
# | La busqueda | Abigail Chase           | Diane Kruger |
# +-------------+-------------------------+--------------+

SQL="USE videoclub; SET CHARACTER SET utf8; SELECT PELIS.titol_peli, ACT_PELI.papel, ACT.nom_actor FROM PELLICULES PELIS INNER JOIN ACTORS_PELLICULES ACT_PELI INNER JOIN ACTORS ACT ON PELIS.id_peli=ACT_PELI.id_peli AND ACT_PELI.id_actor=ACT.id_actor WHERE PELIS.id_peli="$codi_peli

# Generem la comunda per exceutar la consulta, cal ometre els noms de les columnes
consultaAFer=(`echo "$SQL" | mysql -u $UsuariMySQL --password=$PasswordMySQL -h $ServidorMySQL --skip-column-names`)

# La consulta rebrà tots els registres en una cadena (vector), per tant, si coneixem el nombre 
# de columnes, podrem calcular les files rebudes.

# Cal especificar la quantitat de columnes
columnes=3

# Amb el nombre de columnes, deduirem la quatitat de files
files=$[${#consultaAFer[@]} / $columnes]

# Fem servir un for per reòrrer l'array i mostrar les dades
for (( i=0; i<$files; i++ ));
  do
    for (( j=0; j<$columnes; j++ ));
      do
# El nombre de l'element (ELEM), el podem calcular cada vegada, o podem anar incrementant
# en una unitat el valor d'una variable. Cada vegada que llegim un element, 
# tot i que d'aquesta manera sembla més comprensible i escalable.
        ELEM=$[$i * $columnes + $j]
# Mostrem per pantalll'element, sense saltar de línia
        echo -n "${consultaAFer[$ELEM]} - "
      done
# Un cop pintada una fila de la taula, saltem una línia
      echo
done

# Mostrem els valors per pantalla
echo "Total d'elements: "${#consultaAFer[@]}
echo "Columnes        : "$columnes
echo "Files           : "$files

# Recuperem el valor del $IFS como estaba en començar.
IFS=previIFS

# [root@DAW1WEB mysql]# ./consulta.sh 1
# La busqueda - Benjamin Franklin Gates - Nicolas Cage -
# La busqueda - Abigail Chase - Diane Kruger -
# Total d'elements: 6
# Columnes        : 3
# Files           : 2
