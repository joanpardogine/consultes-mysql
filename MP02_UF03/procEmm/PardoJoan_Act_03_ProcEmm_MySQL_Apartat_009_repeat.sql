DELIMITER //
USE videoclub//

DROP PROCEDURE IF EXISTS PardoJoan_Act_03_ProcEmm_MySQL_Apartat_009_repeat//

CREATE PROCEDURE PardoJoan_Act_03_ProcEmm_MySQL_Apartat_009_repeat()
    BEGIN
        DECLARE pa_nomActor       varchar(30);
        DECLARE pa_edatActor      smallint;
        DECLARE pa_sexeActor      varchar(6);
        DECLARE pa_paper          varchar(50);
        
        DECLARE final int DEFAULT 0; -- Igual 0 = False
        
        DECLARE comptador int DEFAULT 0;

       DECLARE cur_RecorrerActors CURSOR FOR
            SELECT nom_actor, year(curdate())-anynaix_actor, sexe_actor
            FROM   ACTORS;

        DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET final=1;

        OPEN cur_RecorrerActors;
        
        REPEAT
            FETCH cur_RecorrerActors INTO pa_nomActor, pa_edatActor, pa_sexeActor;
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
                
                SELECT concat(comptador, ".- L'actor ", pa_nomActor, 
                              " té ", pa_edatActor ,
                              " anys i pot fer", 
                              pa_paper, ".") AS Frase;
                
            ELSE
                SELECT concat(comptador, ".- L'actriu ", pa_nomActor, 
                      " té ", pa_edatActor ,
                      " anys i pot fer", 
                      pa_paper, ".") AS Frase;
 
            END IF;
            
            SET comptador := comptador + 1;
        
        UNTIL final END REPEAT;

SELECT count(nom_actor) as "Qtat total"
            FROM   ACTORS;
            
SELECT comptador as comptador;
  
    END//

DELIMITER ;

-- call PardoJoan_Act_03_ProcEmm_MySQL_Apartat_009_repeat;



