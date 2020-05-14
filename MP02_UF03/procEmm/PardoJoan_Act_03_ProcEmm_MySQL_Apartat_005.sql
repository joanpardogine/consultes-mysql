/*
Dissenya un procediment que rebi un codi de pel·lícula i
torni com a paràmetre global el nom i cognoms i edat del seu actor principal.

pi_codiPeli = 1


mysql> SELECT id_actor
    -> FROM   ACTORS_PELLICULES  ---> INTO pa_codiActorProta
    -> WHERE  id_peli=1 AND principal=1
                       ^--- pi_codiPeli
    -> LIMIT 1;
+----------+
| id_actor |
+----------+
|        1 |  --> pa_codiActorProta
+----------+

 SELECT nom_actor, year(curdate())-anynaix_actor
    -> FROM ACTORS
    -> WHERE id_actor=1;
                      ^--- pa_codiActorProta
+--------------+-------------------------------+
| nom_actor    | year(curdate())-anynaix_actor |
+--------------+-------------------------------+
| Nicolas Cage |                            56 |
+--------------+-------------------------------+

*/

/* Modifiquem el delimitador de sentències a // */
DELIMITER //

/* Canviem a la base de dades empresa per
** assegurar-nos que és la base de dades seleccionada. */
USE videoclub//

/* Procedim a esborrar el procediment que volem
** crear per assegurar-nos que el creem des de zero. */
DROP PROCEDURE IF EXISTS PardoJoan_Act_03_ProcEmm_MySQL_Apartat_005//

CREATE PROCEDURE PardoJoan_Act_03_ProcEmm_MySQL_Apartat_005(
 IN  pi_codiPeli       smallint,
 OUT po_nomsActorProta varchar(30),
 OUT po_edatActorProta smallint)
-- La clàusula BEGIN indica l'inici del procediment.
  BEGIN
-- A partir d'aquí desenvolupem el procediment en si.

-- Declaració de variables. Si cal.
   DECLARE pa_codiActorProta smallint;

SELECT id_actor
   INTO pa_codiActorProta
FROM   ACTORS_PELLICULES
WHERE  id_peli=pi_codiPeli AND principal=1
LIMIT 1;


SELECT nom_actor, year(curdate())-anynaix_actor
    INTO po_nomsActorProta, po_edatActorProta
FROM ACTORS
WHERE id_actor=pa_codiActorProta;

-- La clàusula END indica el final del procediment.
  END //

-- Tornem el delimitador de sentències a l'estàndard que és ;
DELIMITER ;


  
  /*
mysql> call PardoJoan_Act_03_ProcEmm_MySQL_Apartat_005(1,@nom,@edat);
Query OK, 1 row affected (0.00 sec)

mysql> select @nom Nom, @edat Edat;
+--------------+------+
| Nom          | Edat |
+--------------+------+
| Nicolas Cage |   56 |
+--------------+------+
1 row in set (0.00 sec)

  
  */