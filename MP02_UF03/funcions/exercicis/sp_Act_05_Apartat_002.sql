/*
2. Crea un procediment emmagatzemat, per llistar el títol de la pel·lícula
i la quantitat de socis que l'han vist, fent servir la funció creada a l'apartat 1,
per obtenir la quantitat de socis que l'han vist.

 (PELLICULES.titol_peli      | varchar(50)
 
Nom:            sp_Act_05_Apartat_002.sql
Faré servir:    f_Act_05_Apartat_001(id_peli);

Input:          pi_codi_peli     smallint  


mysql> select f_Act_05_Apartat_001(1);
+-------------------------+
| f_Act_05_Apartat_001(1) |
+-------------------------+
|                       4 |
+-------------------------+

*/

/* Modifiquem el delimitador de sentències a // */
DELIMITER //

/* Canviem a la base de dades empresa per
** assegurar-nos que és la base de dades seleccionada. */
USE videoclub//

/* Procedim a esborrar el procediment que volem
** crear per assegurar-nos que el creem des de zero. */
DROP PROCEDURE IF EXISTS sp_Act_05_Apartat_002//

CREATE PROCEDURE sp_Act_05_Apartat_002(
        IN pi_codi_peli smallint)

-- La clàusula BEGIN indica l'inici del procediment.
  BEGIN
  
    DECLARE pa_cadenaTitol   varchar(50);

    SELECT titol_peli
        INTO pa_cadenaTitol
    FROM PELLICULES
    WHERE id_peli=pi_codi_peli;
    
    SELECT concat_ws (" ", 
            "La pelicula",
            pa_cadenaTitol,
            "l'han vist",
            f_Act_05_Apartat_001(pi_codi_peli),
            "socis.") AS Frase;
    
    -- "La pelicula La busqueda l'han vist 4 socis."

     
-- La clàusula END indica el final del procediment.
  END //

-- Tornem el delimitador de sentències a l'estàndard que és ;
DELIMITER ;

/*  sp_Act_05_Apartat_002();

mysql> call sp_Act_05_Apartat_002(1);
+---------------------------------------------+
| Frase                                       |
+---------------------------------------------+
| La pelicula La busqueda l'han vist 4 socis. |
+---------------------------------------------+

*/


