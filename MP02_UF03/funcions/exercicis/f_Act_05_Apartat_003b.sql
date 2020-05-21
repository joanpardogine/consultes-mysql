/*
3. Dissenya una funció que rebi el codi d’una pel·lícula i torni el nom i cognoms del seu actor principal.
*/


/* Modifiquem el delimitador de sentències a // */
DELIMITER //

/* Canviem a la base de dades empresa per
** assegurar-nos que és la base de dades seleccionada. */
USE videoclub//

/* Procedim a esborrar el procediment que volem
** crear per assegurar-nos que el creem des de zero. */
DROP FUNCTION IF EXISTS f_Act_05_Apartat_003//

CREATE FUNCTION f_Act_05_Apartat_003(pe_codi smallint)
        RETURNS varchar(120)

-- La clàusula BEGIN indica l'inici del procediment.
  BEGIN
  
    DECLARE ret_cadenaATornar varchar(120);
    
    DECLARE pa_titol  varchar(50);
    DECLARE pa_nomActor varchar(30);
    DECLARE pa_paper  varchar(40);


-- A partir d'aquí desenvolupem el procediment en si.

-- Declaració de variables. Si cal.

  SELECT PELIS.titol_peli Titol,
         ACT_PELI.papel Paper,
         ACT.nom_actor Actor
    INTO pa_titol, pa_paper, pa_nomActor
  FROM   PELLICULES PELIS
     INNER JOIN ACTORS_PELLICULES ACT_PELI
        INNER JOIN ACTORS ACT
  ON  PELIS.id_peli=ACT_PELI.id_peli 
      AND  ACT_PELI.id_actor=ACT.id_actor
  WHERE PELIS.id_peli=pe_codi
  LIMIT 1;

    -- SET ret_cadenaATornar:=pa_titol; --  + pa_paper + pa_nomActor;
    SET ret_cadenaATornar=concat("A la pelicula ", pa_titol, " en " , pa_nomActor , " fa de ", pa_paper);

    RETURN (ret_cadenaATornar);

-- La clàusula END indica el final del procediment.
  END //

-- Tornem el delimitador de sentències a l'estàndard que és ;
DELIMITER ;

/*  f_Act_05_Apartat_003();
mysql> select f_Act_05_Apartat_003(1);
+-------------------------------------------------------------------------+
| f_Act_05_Apartat_003(1)                                                 |
+-------------------------------------------------------------------------+
| A la pelicula La busqueda en Nicolas Cage fa de Benjamin Franklin Gates |
+-------------------------------------------------------------------------+
1 row in set (0.00 sec)
mysql> select f_Act_05_Apartat_003(5);
+------------------------------------------------------------------+
| f_Act_05_Apartat_003(5)                                          |
+------------------------------------------------------------------+
| A la pelicula Los 4 fantásticos en Jessica Alba fa de Sue Storm  |
+------------------------------------------------------------------+
1 row in set (0.00 sec)
*/
