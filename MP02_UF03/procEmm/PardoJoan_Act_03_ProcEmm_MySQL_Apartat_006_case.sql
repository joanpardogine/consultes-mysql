/*
6. Dissenya un procediment que rebi el codi d’una pel·lícula i torni:
El títol de la pel·lícula.
La rendibilitat de la pel·lícula:
Si ha recaptat menys del pressupostat: Deficitari.
Si ha recaptat menys del doble pressupostat: Suficient.
Si ha recaptat més del doble del pressupostat: Bona.

** Nom: PardoJoan_Act_03_ProcEmm_MySQL_Apartat_006_case.sql
** Paràmetres:
**    Entrada:
**        pe_codi smallint  (id_peli)
**    Sortida:
**        cap
** Mostrarà el titol (titol_peli)  i rendibilitat 

// ****************************************************
rendibliltat =  recaudacio_peli / pressupost_peli
// ----------------------------------------------------
rendibliltat =               1  /  1000          = 0.01
rendibliltat =             150  /  1000          = 0.15
rendibliltat =             500  /  1000          = 0.50
// ----------------------------------------------------
rendibliltat < 1    -->  Recaptació deficitaria
// ----------------------------------------------------
rendibliltat =            1000  /  1000          = 1.00
rendibliltat =            1001  /  1000          = 1.01
rendibliltat =            1150  /  1000          = 1.15
rendibliltat =            1500  /  1000          = 1.50
rendibliltat =            1999  /  1000          = 1.99
// ----------------------------------------------------
rendibliltat < 2    -->  Recaptació suficient
// ----------------------------------------------------
rendibliltat =            2000  /  1000          = 2.00
rendibliltat =            2500  /  1000          = 2.50
rendibliltat =            3000  /  1000          = 3.00
rendibliltat =            3500  /  1000          = 3.50
rendibliltat =            4000  /  1000          = 4.00
// ----------------------------------------------------
rendibliltat > 2    -->  Bona recaptació
// ****************************************************
si (rendibliltat < 1)       // rendibliltat < 1
      llavors
        missatge = "Rendibilitat deficitaria"
sino                        // rendibliltat > 1
    si (rendibliltat < 2)   // rendibliltat < 2
      llavors
        missatge = "Rendibilitat Suficient"
    sino                    // rendibliltat > 2
        missatge = "Bona Rendibilitat"  
    fi si
fi si
// ****************************************************

** Farem servir la taula:
**   PELLICULES
desc PELLICULES;
+-----------------+----------------------+------+-----+---------+-------+
| Field           | Type                 | Null | Key | Default | Extra |
+-----------------+----------------------+------+-----+---------+-------+
| id_peli         | smallint(5) unsigned | NO   | PRI | NULL    |       |
| titol_peli      | varchar(50)          | YES  |     | NULL    |       |
| nacio_peli      | varchar(20)          | YES  |     | NULL    |       |
| produ_peli      | varchar(25)          | YES  |     | NULL    |       |
| any_peli        | smallint(5) unsigned | YES  |     | NULL    |       |
| id_dire_peli    | smallint(5) unsigned | YES  | MUL | NULL    |       |
| recaudacio_peli | bigint(20) unsigned  | YES  |     | NULL    |       |
| pressupost_peli | bigint(20) unsigned  | YES  |     | NULL    |       |
+-----------------+----------------------+------+-----+---------+-------+

mysql> SELECT titol_peli titol, (recaudacio_peli/pressupost_peli) Rendi
    -> FROM   PELLICULES
    -> WHERE  id_peli=1 ;
+-------------+--------+
| titol       | Rendi  |
+-------------+--------+
| La busqueda | 1.7444 |
+-------------+--------+

 SELECT titol_peli titol, (recaudacio_peli/pressupost_peli) Rendi FROM   PELLICULES WHERE  id_peli=2;
+-------------+--------+
| titol       | Rendi  |
+-------------+--------+
| La terminal | 2.3469 |
+-------------+--------+

 SELECT titol_peli titol, (recaudacio_peli/pressupost_peli) Rendi FROM   PELLICULES;
+-------------------------------------------+--------+
| titol                                     | Rendi  |
+-------------------------------------------+--------+
| La busqueda                               | 1.7444 |  S
| La terminal                               | 2.3469 |
| Mar adentro                               | 3.8535 |
| Colateral                                 | 3.3502 |
| Los 4 fantásticos                         | 1.7542 |  S
| Sin City                                  | 1.8154 |  S
| Iron Man                                  | 4.1798 |
| Los Vengadores                            | 6.9071 |
| Los Vengadores: La era de Ultron          | 5.6217 |
| La busqueda 2: El diario secreto          | 3.5182 |
| Iron Man 2                                | 3.1197 |
| Iron Man 3                                | 6.0772 |
| Capitán América: El primer vengador       | 2.6469 |
| Capitán América: El Soldado de Invierno   | 4.2045 |
| Capitán América: Civil War                | 4.6132 |
+-------------------------------------------+--------+

pi_codiPeli = 1


mysql> SELECT titol_peli, recaudacio_peli, pressupost_peli
    -> FROM   PELLICULES
    -> WHERE  id_peli=1 ;
                          ^--- pi_codiPeli
+-------------+-----------------+-----------------+
| titol_peli  | recaudacio_peli | pressupost_peli |
+-------------+-----------------+-----------------+
| La busqueda |       174443000 |       100000000 |
+-------------+-----------------+-----------------+
    
si  recaudacio_peli < pressupost_peli
      llavors
        missatge="Rendibilitat deficitaria"
sino  
    si recaudacio_peli < (pressupost_peli x 2)
      llavors
        missatge="Rendibilitat Suficient"
    sino
        missatge="Bona Rendibilitat"  
    fi si
fi si


pa_nomPeli      varchar(50)
pa_PresPeli     bigint
pa_RecaPeli     bigint



*/

/* Modifiquem el delimitador de sentències a // */
DELIMITER //

/* Canviem a la base de dades empresa per
** assegurar-nos que és la base de dades seleccionada. */
USE videoclub//

/* Procedim a esborrar el procediment que volem
** crear per assegurar-nos que el creem des de zero. */
DROP PROCEDURE IF EXISTS PardoJoan_Act_03_ProcEmm_MySQL_Apartat_006_case//

CREATE PROCEDURE PardoJoan_Act_03_ProcEmm_MySQL_Apartat_006_case(
 IN  pi_codiPeli       smallint)
-- La clàusula BEGIN indica l'inici del procediment.
  BEGIN
-- A partir d'aquí desenvolupem el procediment en si.

-- Declaració de variables. Si cal.
   DECLARE pa_nomPeli       varchar(50);
   DECLARE pa_RendPeli      float;
   DECLARE pa_missatge      varchar(50);

SELECT titol_peli, (recaudacio_peli/pressupost_peli)
   INTO pa_nomPeli, pa_RendPeli
FROM   PELLICULES
WHERE  id_peli=pi_codiPeli; 

/* ****************************************************
si (rendibliltat < 1)       // rendibliltat < 1
      llavors
        missatge = "Rendibilitat deficitaria"
sino                        // rendibliltat > 1
    si (rendibliltat < 2)   // rendibliltat < 2
      llavors
        missatge = "Rendibilitat Suficient"
    sino                    // rendibliltat > 2
        missatge = "Bona Rendibilitat"  
    fi si
fi si
// **************************************************** */


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

SELECT concat("La peli ", pa_nomPeli, pa_missatge);


-- La clàusula END indica el final del procediment.
  END //

-- Tornem el delimitador de sentències a l'estàndard que és ;
DELIMITER ;

  
  /*
 call PardoJoan_Act_03_ProcEmm_MySQL_Apartat_006_case(1);
+-----------------------------------------------------+
| concat("La peli ", pa_nomPeli, pa_missatge)         |
+-----------------------------------------------------+
| La peli La busqueda té una rendibilitat suficient.  |
+-----------------------------------------------------+

  
  */
  
  
  