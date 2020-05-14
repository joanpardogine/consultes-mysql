/*
9. Emprant l’activitat 7, de l'Activitat 3.

*/


/* Modifiquem el delimitador de sentències a // */
DELIMITER //

/* Canviem a la base de dades empresa per
** assegurar-nos que és la base de dades seleccionada. */
USE videoclub//

/* Procedim a esborrar el procediment que volem
** crear per assegurar-nos que el creem des de zero. */
DROP PROCEDURE IF EXISTS PardoJoan_Act_03_ProcEmm_MySQL_Apartat_009_b//

CREATE PROCEDURE PardoJoan_Act_03_ProcEmm_MySQL_Apartat_009_b()
    BEGIN
        DECLARE pa_nomActor       varchar(30);
        DECLARE pa_edatActor      smallint;
        DECLARE pa_sexeActor      varchar(6);
        DECLARE pa_paper          varchar(50);
        
        DECLARE cadenaFinal       varchar(255) DEFAULT "";
        DECLARE cadenaParcial       varchar(255);
        
        DECLARE final int DEFAULT 0; -- Igual 0 = False
        
        DECLARE comptador int DEFAULT 0;

-- 1.- Declarar un cursor i associar-lo a una consulta que torna MÉS d'un registre.
       DECLARE cur_RecorrerActors CURSOR FOR
            SELECT nom_actor, year(curdate())-anynaix_actor, sexe_actor
            FROM   ACTORS;



            
-- 2.- Declarar un controlador per finalizar el recorregut del cursor.
        DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET final=1;
    --    DECLARE CONTINUE HANDLER FOR NOT FOUND SET final = 1; -- True

-- 3.- Obrir un cursor per poder recórrer tots els registres que conté.
        OPEN cur_RecorrerActors;
   
        buclePerRecorrerTotsElsRegistres:LOOP
        
        -- REPEAT
-- 4.- Obtenir el següent element del cursor.
            FETCH cur_RecorrerActors INTO pa_nomActor, pa_edatActor, pa_sexeActor;
            SET cadenaParcial = "";
             IF final=1 THEN
                 LEAVE buclePerRecorrerTotsElsRegistres;
             END IF;

--  cos pel procesament de dades
            CASE
                WHEN pa_edatActor < 15 THEN
                    IF pa_sexeActor = "home" THEN
                        SET pa_paper = " de nen";
                    ELSE
                         SET pa_paper = " de nena";
                    END IF;
                    
                WHEN pa_edatActor <= 25 THEN
                    IF pa_sexeActor = "home" THEN
                        SET pa_paper = " d'home adolescent i jove";
                    ELSE
                         SET pa_paper = " de dona adolescent i jove";
                    END IF;
                    
                WHEN pa_edatActor <= 40 THEN
                    IF pa_sexeActor = "home" THEN
                        SET pa_paper = " d'home adult";
                    ELSE
                         SET pa_paper = " de dona adulta";
                    END IF;
                    
                WHEN pa_edatActor <= 60 THEN
                    IF pa_sexeActor = "home" THEN
                        SET pa_paper = " d'home madur";
                    ELSE
                         SET pa_paper = " de dona madura";
                    END IF;
                    
                WHEN pa_edatActor > 60 THEN
                    IF pa_sexeActor = "home" THEN
                        SET pa_paper = " d'home gran";
                    ELSE
                        SET pa_paper = " de dona gran";
                    END IF;
            END CASE;
            
            IF pa_sexeActor = "home" THEN
                SELECT concat("L'actor ", pa_nomActor, 
                              " té ", pa_edatActor ,
                              " anys i pot fer", 
                              pa_paper, ".") AS Frase;
                
                
                SET cadenaParcial = concat_ws(' ', "L'actor ", pa_nomActor, 
                              " té ", pa_edatActor ,
                              " anys i pot fer", 
                              pa_paper, ".");
            ELSE
                SELECT concat("L'actriu ", pa_nomActor, 
                      " té ", pa_edatActor ,
                      " anys i pot fer", 
                      pa_paper, ".") AS Frase;
                SET cadenaParcial = concat_ws(' ', "L'actor ", pa_nomActor, 
                              " té ", pa_edatActor ,
                              " anys i pot fer", 
                              pa_paper, ".");
            END IF;
            SET cadenaFinal = concat_ws(CHAR(10 using utf8), cadenaFinal, cadenaParcial);
    --  cos pel procesament de dades   
            SET comptador := comptador + 1;
        
          END LOOP buclePerRecorrerTotsElsRegistres;

SELECT concat("", cadenaFinal);
  
    END//

DELIMITER ;

/* 
 call PardoJoan_Act_03_ProcEmm_MySQL_Apartat_009_b();

mysql> call PardoJoan_Act_03_ProcEmm_MySQL_Apartat_009_b();
+----------------------------------------------------------+
| Frase                                                    |
+----------------------------------------------------------+
| L'actor Nicolas Cage té 56 anys i pot fer d'home madur.  |
+----------------------------------------------------------+
1 row in set (0.00 sec)

+-------------------------------------------------------------+
| Frase                                                       |
+-------------------------------------------------------------+
| L'actriu Diane Kruger té 44 anys i pot fer de dona madura.  |
+-------------------------------------------------------------+
1 row in set (0.00 sec)

+------------------------------------------------------+
| Frase                                                |
+------------------------------------------------------+
| L'actor Tom Hanks té 64 anys i pot fer d'home gran.  |
+------------------------------------------------------+
1 row in set (0.00 sec)


...
*/
