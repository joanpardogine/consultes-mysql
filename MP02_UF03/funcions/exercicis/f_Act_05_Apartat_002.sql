/*
Dissenya una funció que torni el codi de la pel·lícula que més ha recaptat.

*/

/* Modifiquem el delimitador de sentències a // */
DELIMITER //

/* Canviem a la base de dades empresa per
** assegurar-nos que és la base de dades seleccionada. */
USE videoclub//

/* Procedim a esborrar el procediment que volem
** crear per assegurar-nos que el creem des de zero. */
DROP FUNCTION IF EXISTS f_Act_05_Apartat_002//

CREATE FUNCTION f_Act_05_Apartat_002()
        RETURNS smallint

-- La clàusula BEGIN indica l'inici del procediment.
  BEGIN
  
    DECLARE ret_codipeli_maxRecaptacio smallint;
    
-- A partir d'aquí desenvolupem el procediment en si.
--     DECLARE pl_maxRecaptacio bigint;

    SELECT id_peli   
      INTO ret_codipeli_maxRecaptacio
    FROM PELLICULES
    ORDER BY recaudacio_peli DESC
    LIMIT 1;
    
/*

SELECT id_peli FROM PELLICULES ORDER BY recaudacio_peli DESC LIMIT 1;

SELECT max(recaudacio_peli)
      INTO pl_maxRecaptacio
    FROM PELLICULES;

    SELECT id_peli
      INTO ret_codipeli_maxRecaptacio
    FROM PELLICULES
    WHERE recaudacio_peli = pl_maxRecaptacio;
*/

    RETURN (ret_codipeli_maxRecaptacio);

-- La clàusula END indica el final del procediment.
  END //



-- Modifiquem el delimitador de sentències a l'estàndard que és ;
DELIMITER ;

/*
mysql> SELECT f_Act_05_Apartat_002();
+------------------------+
| f_Act_05_Apartat_002() |
+------------------------+
|                      8 |
+------------------------+

*/


