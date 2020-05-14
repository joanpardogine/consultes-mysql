# Funcions MYSQL
Les funcions programades per l'usuari es comporten igual que les funcions natives dels SGBD. Poden veure's d'igual manera com a caixes negres a les quals se'ls pot passar de zero a diversos paràmetres d'entrada, i retornen un únic valor de sortida. Per a il·lustrar com programar una funció senzilla, considerarem que necessitem unificar en una tercera columna, dues columnes numèriques que retorna una consulta SQL, de manera que la nova columna contingui el valor major d'entre les altres dues columnes. La funció ha de ser genèrica, és a dir, per a dos valors donats ha de determinar el major i retornar-ho com a resultat de l'operació.
En construir la funció s'han usat majúscules per a diferenciar els noms que tria el programador de les instruccions i per tant paraules reservades del llenguatge.

```sql
CREATE FUNCTION MAJOR (inValor1 INT, inValor2 INT) RETURNS INT
    BEGIN
        DECLARE outValorATornar INT;
        IF inValor1 > inValor2 THEN
            SET outValorATornar = inValor1;
        ELSE
            SET outValorATornar = inValor2;
        END IF;
        RETURN outValorATornar;
END;
```

## Analitzant les parts del codi de la funció MAJOR.

**`inValor1`** i **`inValor2`** són els dos paràmetres d'entrada, per als quals ha d'especificar-se el tipus de dada, en aquest cas tots dos són de tipus **`INT`**. Veiem també a la capçalera de la funció com s'especifica el tipus de dada que retorna, en aquest cas tipus **`INT`**. Per tant la funció **`MAJOR`** rep dos enters com a paràmetres d'entrada, i retorna un enter com a resultat de l'operació o valor de sortida.
A continuació ve el bloc de codi entre les paraules reservades **`BEGIN`** i **`END`**, en aquest espai es programa la lògica que ha de realitzar la funció. La primera instrucció que apareix és una declaració de variable: **`outValorATornar`**, per a la qual deu també especificar-se el tipus de dada, en aquest cas també tipus **`INT`**. La variable té el propòsit de guardar el valor que la funció acabarà retornant.
Seguidament trobem la instrucció **`IF`**, que permet establir condicions.
En funció del resultat de la condició, que només pot ser cert o fals, es realitzen unes accions o unes altres. En aquest cas s'observa com la instrucció **`IF`** compara els paràmetres d'entrada entre si de manera que si **`inValor1`** és major que **`inValor2`**, llavors s'executa la instrucció **`SET`** que hi ha dins del **`IF`**, és a dir, s'assigna el valor que conté **`inValor1`** a la variable **`outValorATornar`**. Si per contra la condició resulta ser falsa, en lloc d'executar-se la instrucció que hi ha dins del **`IF`** s'executarà la que hi ha dins del **`ELSE`**, i s'assignarà el valor que conté **`inValor2`** a la variable **`outValorATornar`**.
Al final de tot està la instrucció **`RETURN`** que retorna el contingut de la variable **`outValorATornar`** prèviament calculat i finalitza l'execució de la funció.
Vegem a continuació una aplicació de la funció **`MAJOR`**.

```sql
mysql> select MAJOR(34, 27)
MAJOR(34, 27)
34
```

Aplicat a dues columnes d'una consulta:

```sql
select ID_ALUMNO,
ID_CURSO,
MAJOR(ID_ALUMNO, ID_CURSO) as MAJOR
 from ALUMNOS_CURSOS
 ```