/*
2. Utilitza la funció creada a l'apartat 1, per llistar el títol de la
pel·lícula i la quantitat de socis que l'han vist, en un procediment
emmagatzemat.
 (PELLICULES.titol_peli      | varchar(50)
 
Nom:            f_Act_05_Apartat_002.sql
Faré servir:    f_Act_05_Apartat_001(id_peli);

Input:      pi_codi_peli     smallint  
Return:     ret_TitolPeli    varchar(50)

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
DROP FUNCTION IF EXISTS f_Act_05_Apartat_002//

CREATE FUNCTION f_Act_05_Apartat_002(pi_codi_peli smallint)
        RETURNS varchar(150)

-- La clàusula BEGIN indica l'inici del procediment.
  BEGIN
  
    DECLARE pa_cadenaTitol   varchar(50);
    DECLARE pa_QtatUSuaris   int;
    
    DECLARE ret_cadenaTitolPeliIQtatUSuaris    varchar(150);
    
    SELECT titol_peli
        INTO pa_cadenaTitol
    FROM PELLICULES
    WHERE id_peli=pi_codi_peli;
    
    SELECT f_Act_05_Apartat_001(pi_codi_peli)
        INTO pa_QtatUSuaris;
    
    SET ret_cadenaTitolPeliIQtatUSuaris = concat_ws (" ", 
            "La pelicula",
            pa_cadenaTitol,
            "l'han vist",
            pa_QtatUSuaris,
            "socis.");
    
    -- "La pelicula La busqueda l'han vist 4 socis."


     RETURN (ret_cadenaTitolPeliIQtatUSuaris);
     
-- La clàusula END indica el final del procediment.
  END //

-- Tornem el delimitador de sentències a l'estàndard que és ;
DELIMITER ;

/*  f_Act_05_Apartat_002();

mysql> select f_Act_05_Apartat_002(1);
+---------------------------------------------+
| f_Act_05_Apartat_002(1)                     |
+---------------------------------------------+
| La pelicula La busqueda l'han vist 4 socis. |
+---------------------------------------------+

*/

