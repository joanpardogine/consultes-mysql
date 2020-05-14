# Funcions MYSQL
Les funcions programades per l'usuari es comporten igual que les funcions natives dels SGBD. Poden veure's d'igual manera com a caixes negres a les quals se'ls pot passar de zero a diversos paràmetres d'entrada, i retornen un únic valor de sortida.

## Funció senzilla **`f_holaMon`**.
Per a il·lustrar com programar una funció senzilla, considerarem que volem tornar la cadena que rebem com a paràmetre, afegida a la paraula **`"Hola"`**.

```sql

DELIMITER //

USE videoclub //

DROP FUNCTION IF EXISTS f_holaMon //

CREATE FUNCTION f_holaMon(pi_cadena VARCHAR(20)) RETURNS VARCHAR(50)
        RETURN CONCAT('Hola ',pi_cadena,'!'); //

DELIMITER ;


mysql> SELECT f_holaMon("món") AS Missatge;
+------------+
| Missatge   |
+------------+
| Hola món!  |
+------------+
1 row in set (0.00 sec)
```

## Analitzant les parts del codi de la funció **`f_holaMon`**.

**`pi_cadena`** és el paràmetre d'entrada, per al qual cal especificar el tipus de dada, en aquest cas és tipus **`VARCHAR(20)`**. Veiem també a la capçalera de la funció com s'especifica el tipus de dada que retorna, en aquest cas tipus **`VARCHAR(50)`**. Per tant la funció **`f_holaMon`** rep una cadena a paràmetre d'entrada, i retorna una cadena a amb la paraula **`"Hola"`**, un espai, el valor del paràmetre d'entrada **`pi_cadena`** i finalment un símbol d'admiració **`"!"`** com a cadena de sortida.

## Funció una mica més complexa **`f_major`**.
Ara considerarem que necessitem unificar en una tercera columna, dues columnes numèriques que retorna una consulta SQL, de manera que la nova columna contingui el valor major d'entre les altres dues columnes. La funció ha de ser genèrica, és a dir, per a dos valors donats ha de determinar el major i retornar-ho com a resultat de l'operació.

```sql

DELIMITER //

USE videoclub //

DROP FUNCTION IF EXISTS f_major //

CREATE FUNCTION f_major(inValor1 INT, inValor2 INT) RETURNS INT
    BEGIN
        DECLARE outValorATornar INT;
        IF inValor1 > inValor2 THEN
            SET outValorATornar = inValor1;
        ELSE
            SET outValorATornar = inValor2;
        END IF;
        RETURN outValorATornar;
    END //

DELIMITER ;

```

## Analitzant les parts del codi de la funció **`f_major`**.

**`inValor1`** i **`inValor2`** són els dos paràmetres d'entrada, per als quals ha d'especificar-se el tipus de dada, en aquest cas tots dos són de tipus **`INT`**. Veiem també a la capçalera de la funció, com abans, s'especifica el tipus de dada que retorna, en aquest cas tipus **`INT`**. Per tant la funció **`f_major`** rep dos enters com a paràmetres d'entrada, i retorna un enter com a resultat de l'operació o valor de sortida.
A continuació ve el bloc de codi entre les paraules reservades **`BEGIN`** i **`END`**, en aquest espai es programa la lògica que ha de realitzar la funció. La primera instrucció que apareix és una declaració de variable: **`outValorATornar`**, per a la qual deu també especificar-se el tipus de dada, en aquest cas també tipus **`INT`**. La variable té el propòsit de guardar el valor que la funció acabarà retornant.
Seguidament trobem la instrucció **`IF`**, que permet establir condicions.
En funció del resultat de la condició, que només pot ser cert o fals, es realitzen unes accions o unes altres. En aquest cas s'observa com la instrucció **`IF`** compara els paràmetres d'entrada entre si de manera que si **`inValor1`** és major que **`inValor2`**, llavors s'executa la instrucció **`SET`** que hi ha dins del **`IF`**, és a dir, s'assigna el valor que conté **`inValor1`** a la variable **`outValorATornar`**. Si per contra la condició resulta ser falsa, en lloc d'executar-se la instrucció que hi ha dins del **`IF`** s'executarà la que hi ha dins del **`ELSE`**, i s'assignarà el valor que conté **`inValor2`** a la variable **`outValorATornar`**.
Al final de tot està la instrucció **`RETURN`** que retorna el contingut de la variable **`outValorATornar`** prèviament calculat i finalitza l'execució de la funció.
Vegem a continuació una aplicació de la funció **`f_major`**.

```sql
mysql> select f_major(34, 27);
+-----------------+
| f_major(34, 27) |
+-----------------+
|              34 |
+-----------------+
```

Aplicat a dues columnes d'una consulta:

```sql

mysql> SELECT id_peli AS "Codi Peli",
    ->        id_actor  AS "Codi Actor",
    ->        f_major(id_peli, id_actor) AS "el més gran"
    -> FROM ACTORS_PELLICULES;
+-----------+------------+--------------+
| Codi Peli | Codi Actor | el més gran  |
+-----------+------------+--------------+
|         1 |          1 |            1 |
|        10 |          1 |           10 |
...
|        13 |         20 |           20 |
|        14 |         20 |           20 |
|        15 |         20 |           20 |
+-----------+------------+--------------+
46 rows in set (0.00 sec)

 ```

 ## Funció amb accés a dades **`f_sumaSous`**

La següent funció d'exemple MySQL calcula la suma de salaris de la taula **`TREBALLADORS`**, té un paràmetre d'entrada per a indicar-li el departament dels treballadors que s'han de considerar per realitzar el càlcul. Però si no s'especifica el departament, o cosa que és el mateix, la invoquem passant-li un valor nul, calcula la suma de salaris de tota la taula.

```sql

DELIMITER //

USE empresa //

DROP FUNCTION IF EXISTS f_sumaSous //

CREATE FUNCTION f_sumaSous(pi_responsable  smallint)
    RETURNS float
    BEGIN
        DECLARE pa_sumaSous float;

        SELECT sum(SOU_TREB)
            INTO pa_sumaSous 
        FROM TREBALLADORS
        WHERE CAP_TREB=pi_responsable
                OR pi_responsable IS NULL;  -- OR ISNULL(pi_responsable);
        
        RETURN pa_sumaSous;
    END //

DELIMITER ;

mysql> SELECT f_sumaSous(7698);
+------------------+
| f_sumaSous(7698) |
+------------------+
| 5117.60986328125 |
+------------------+

mysql> SELECT sum(SOU_TREB)
    -> FROM TREBALLADORS
    -> WHERE CAP_TREB = 7698;
+---------------+
| sum(SOU_TREB) |
+---------------+
|       5117.61 |
+---------------+


mysql> SELECT f_sumaSous(NULL);
+------------------+
| f_sumaSous(NULL) |
+------------------+
|    22677.6796875 |
+------------------+

mysql> SELECT sum(SOU_TREB)
    -> FROM TREBALLADORS;
+---------------+
| sum(SOU_TREB) |
+---------------+
|      22677.68 |
+---------------+
```
## Analitzant les parts del codi de la funció **`f_sumaSous`**.
Fixeu-vos com en la consulta que conté la funció apareix una clàusula que ja s'havia tractat amb anterioritat, la clàusula **`INTO`**. Com amb els Storage Procedures, té el propòsit d'assignar els valors que retorna la consulta a variables per al seu tractament o ús. En aquest cas la suma de salaris que retorna la consulta s'assigna a la variable **`pa_sumaSous`**, que s'usa com a valor de retorn de la funció. Si en la clàusula **`SELECT`** apareixen més columnes o camps, haurà d'especificar en la clàusula **`INTO`** una variable per a cada columna que indiqui en la clàusula **`SELECT`**, separant una variable d'una altra per comes. Aquestes variables han de ser del mateix tipus que el valor que retorna la consulta en la seva columna corresponent. Si aquestes consultes retornen més d'una sola fila de resultat, si retornen dos o més es produeix un error en temps d'execució, atès que no és possible assignar a una variable els valors de diverses files de resultat. En aquest cas caldria fer servir un cursor de MySQL.
Provem el bon funcionament de la funció **`f_sumaSous`** mitjançant la següent consulta:

```sql



mysql> sELECT DISTINCT CAP_TREB  FROM TREBALLADORS;
+----------+
| CAP_TREB |
+----------+
|     NULL |
|     7566 |
|     7698 |
|     7782 |
|     7788 |
|     7839 |
|     7902 |
+----------+


SELECT 'Codi 7566' Responsble, f_sumaSous(7566) AS "Total Sous"
    UNION SELECT 'Codi 7698', f_sumaSous(7698)
    UNION SELECT 'Codi 7782', f_sumaSous(7782)
    UNION SELECT 'Codi 7788', f_sumaSous(7788)
    UNION SELECT 'Codi 7782', f_sumaSous(7782)
    UNION SELECT 'Codi 7839', f_sumaSous(7839)
    UNION SELECT 'Codi 7902', f_sumaSous(7902)
    UNION SELECT 'Tots', f_sumaSous(NULL);

mysql> SELECT 'Codi 7566' Responsble, f_sumaSous(7566) AS "Total Sous"
    ->     UNION SELECT 'Codi 7698', f_sumaSous(7698)
    ->     UNION SELECT 'Codi 7782', f_sumaSous(7782)
    ->     UNION SELECT 'Codi 7788', f_sumaSous(7788)
    ->     UNION SELECT 'Codi 7782', f_sumaSous(7782)
    ->     UNION SELECT 'Codi 7839', f_sumaSous(7839)
    ->     UNION SELECT 'Codi 7902', f_sumaSous(7902)
    ->     UNION SELECT 'Tots', f_sumaSous(NULL);
+------------+------------+
| Responsble | Total Sous |
+------------+------------+
| Codi 7566  |     4687.9 |
| Codi 7698  |    5117.61 |
| Codi 7782  |    1015.71 |
| Codi 7788  |     859.45 |
| Codi 7839  |    6465.38 |
| Codi 7902  |     625.05 |
| Tots       |    22677.7 |
+------------+------------+
```