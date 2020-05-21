/*
3. Dissenya una funció que rebi el codi d’una pel·lícula i torni el nom i
cognoms del seu actor principal.

Nom:            f_Act_05_Apartat_003.sql
Input:          pi_codi_peli     smallint 
Return:         ret_nom_Prota    varchar(30)

ACTORS_PELLICULES.id_actor      | smallint
ACTORS. nom_actor               | varchar(30) 

pa_codi_Actor   smallint
ret_nom_Prota    varchar(30) 

SELECT id_actor
FROM ACTORS_PELLICULES
WHERE principal = 1 AND
      id_peli=pi_codi_peli
LIMIT 1;

SELECT nom_actor
    INTO ret_nom_Prota
FROM ACTORS
WHERE id_actor=pa_codi_Actor
*/


/* Modifiquem el delimitador de sentències a // */
DELIMITER //

/* Canviem a la base de dades empresa per
** assegurar-nos que és la base de dades seleccionada. */
USE videoclub//

/* Procedim a esborrar el procediment que volem
** crear per assegurar-nos que el creem des de zero. */
DROP FUNCTION IF EXISTS f_Act_05_Apartat_003//

CREATE FUNCTION f_Act_05_Apartat_003(
        pi_codi_peli smallint)
        RETURNS  varchar(30)

-- La clàusula BEGIN indica l'inici del procediment.
  BEGIN
  
    DECLARE pa_codi_Prota   smallint;
    DECLARE ret_nom_Prota   varchar(30);
    
    
    SELECT id_actor
        INTO pa_codi_Prota
    FROM ACTORS_PELLICULES
    WHERE principal = 1 AND
          id_peli=pi_codi_peli
    LIMIT 1;


    SELECT nom_actor
        INTO ret_nom_Prota
    FROM ACTORS
    WHERE id_actor=pa_codi_Prota;
    
    RETURN(ret_nom_Prota);
    
-- La clàusula END indica el final del procediment.
  END //

-- Tornem el delimitador de sentències a l'estàndard que és ;
DELIMITER ;

/*  
mysql> SELECT f_Act_05_Apartat_003(8);
+-------------------------+
| f_Act_05_Apartat_003(8) |
+-------------------------+
| Robert Downey Jr.       |
+-------------------------+

mysql> SELECT id_actor
    -> FROM ACTORS_PELLICULES
    -> WHERE principal = 1 AND
    ->       id_peli=8 LIMIT 1;
+----------+
| id_actor |
+----------+
|       10 |
+----------+

mysql> SELECT nom_actor
    -> FROM ACTORS
    -> WHERE id_actor=10;
+-------------------+
| nom_actor         |
+-------------------+
| Robert Downey Jr. |
+-------------------+
*/
