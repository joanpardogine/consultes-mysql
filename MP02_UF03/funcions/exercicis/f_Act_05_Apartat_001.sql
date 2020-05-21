/*
1. Dissenya una funció que rebent un codi de pel·lícula torni el número
d’usuaris que l’han vist.
Nom:        f_Act_05_Apartat_001.sql

Input:      pi_codi_peli            smallint  
Return:     ret_SocisQueLHanVist   int

mysql>  SELECT count(id_soci)
        FROM VISUALITZACIONS
        WHERE id_peli=1;
+----------------+
| count(id_soci) |
+----------------+
|              4 |
+----------------+

*/


/* Modifiquem el delimitador de sentències a // */
DELIMITER //

/* Canviem a la base de dades empresa per
** assegurar-nos que és la base de dades seleccionada. */
USE videoclub//

/* Procedim a esborrar el procediment que volem
** crear per assegurar-nos que el creem des de zero. */
DROP FUNCTION IF EXISTS f_Act_05_Apartat_001//

CREATE FUNCTION f_Act_05_Apartat_001(pi_codi_peli smallint)
        RETURNS int

-- La clàusula BEGIN indica l'inici del procediment.
  BEGIN
  
    DECLARE ret_SocisQueLHanVist int;
    

        SELECT count(id_soci)
            INTO ret_SocisQueLHanVist
        FROM VISUALITZACIONS
        WHERE id_peli=pi_codi_peli;

     RETURN (ret_SocisQueLHanVist);
     
-- La clàusula END indica el final del procediment.
  END //

-- Tornem el delimitador de sentències a l'estàndard que és ;
DELIMITER ;

/*  f_Act_05_Apartat_001();
mysql> select f_Act_05_Apartat_001(1);
+-------------------------+
| f_Act_05_Apartat_001(1) |
+-------------------------+
|                       4 |
+-------------------------+
*/
