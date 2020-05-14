/*
8. Emprant l’activitat 6, de l'Activitat 3.

*/


/* Modifiquem el delimitador de sentències a // */
DELIMITER //

/* Canviem a la base de dades empresa per
** assegurar-nos que és la base de dades seleccionada. */
USE videoclub//

/* Procedim a esborrar el procediment que volem
** crear per assegurar-nos que el creem des de zero. */
DROP PROCEDURE IF EXISTS PardoJoan_Act_03_ProcEmm_MySQL_Apartat_008_rep//

CREATE PROCEDURE PardoJoan_Act_03_ProcEmm_MySQL_Apartat_008_rep()

-- La clàusula BEGIN indica l'inici del procediment.
  BEGIN
-- A partir d'aquí desenvolupem el procediment en si.

-- Declaració de variables. Si cal.
   DECLARE pa_nomPeli       varchar(50);
   DECLARE pa_RendPeli      float;
   DECLARE pa_missatge      varchar(50);
   
   DECLARE final int DEFAULT 0; -- Igual 0 = False

-- 1.- Declarar un cursor i associar-lo a una consulta que torna MÉS d'un registre.
   DECLARE elcursor CURSOR FOR
        SELECT titol_peli, (recaudacio_peli/pressupost_peli)
        FROM   PELLICULES; 

-- 2.- Declarar un controlador per finalizar el recorregut del cursor.
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET final = 1; -- True
    
    /*
    DECLARE CONTINUE HANDLER FOR ERROR 1338 SET final = 1;
    */
    
-- 3.- Obrir un cursor per poder recórrer tots els registres que conté.
    OPEN elcursor;

-- marquem l'INICI del bucle -> etiqueta "elbucle"
     -- elbucle:LOOP
    REPEAT
    
    
-- 4.- Obtenir el següent element del cursor.
        FETCH elcursor INTO pa_nomPeli, pa_RendPeli;
        
-- si el FETCH reb un NOT FOUND executarà el controlador definit pel NOT FOUND
   /*
   IF final = 1 THEN
            LEAVE elbucle;    -- ens indica que sortim del bucle
        END IF;
*/

        
--  cos pel procesament de dades

        case
          when pa_RendPeli <= 1 THEN SET pa_missatge = " té una rendibilitat deficitaria";
          when pa_RendPeli < 2  THEN set pa_missatge = " té una rendibilitat suficient";
          when pa_RendPeli >= 2  THEN set pa_missatge = " té una bona Rendibilitat";
        end case;
        
        /*
        IF pa_RendPeli < 1 THEN 
                set pa_missatge = " té una rendibilitat deficitaria.";
           ELSE 
             IF pa_RendPeli < 2 THEN  
               set pa_missatge = " té una rendibilitat suficient.";
             ELSE
               set  pa_missatge = " té una bona rendibilitat.";
             END IF;
        END IF;
        */
        
        SELECT concat("La peli ", pa_nomPeli, pa_missatge) AS "Aquesta és la rendibilitat!";
--  cos pel procesament de dades

      -- END LOOP elbucle;
      UNTIL final
      END REPEAT;
-- marquem el FINAL del bucle -> etiqueta "elbucle"

-- 5.-    Tancar el cursor.
    CLOSE elcursor;
        
-- La clàusula END indica el final del procediment.
  END //

-- Tornem el delimitador de sentències a l'estàndard que és ;
DELIMITER ;


  /*
mysql>   call PardoJoan_Act_03_ProcEmm_MySQL_Apartat_008_rep;
+-----------------------------------------------------+
| Aquesta és la rendibilitat!                         |
+-----------------------------------------------------+
| La peli La busqueda té una rendibilitat suficient.  |
+-----------------------------------------------------+
1 row in set (0.00 sec)

+------------------------------------------------+
| Aquesta és la rendibilitat!                    |
+------------------------------------------------+
| La peli La terminal té una bona rendibilitat.  |
+------------------------------------------------+
1 row in set (0.00 sec)

+------------------------------------------------+
|Aquesta és la rendibilitat!                     |
+------------------------------------------------+
| La peli Mar adentro té una bona rendibilitat.  |
+------------------------------------------------+
1 row in set (0.00 sec)

  
  */
  
  