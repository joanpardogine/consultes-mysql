/*
** Sobre la base de dades videoclub.
** Actiitat 1: Dissenya un procediment que rebi un
** codi de pel·lícula i mostri per pantalla el nom
** de la pel·lícula i els actors/actrius que hi
** actuen, juntament amb el paper que interpreten.
** Nom: PardoJoan_Act_03_ProcEmm_MySQL_Apartat_001.sql
** Paràmetres:
**    Entrada:
**        pe_codi smallint
**    Sortida:
**        cap
** Farem servir les taules:
**    PELLICULES          PELIS
**    ACTORS_PELLICULES   ACT_PELI
**    ACTORS              ACT

rebi:
      el codi de pel·lícula -> PELIS.id_peli
    que guardarem a la variable:
      pe_codi
mostri per pantalla:
    1)  el nom de la pel·lícula
        taula: PELIS
        camp : PELIS.titol_peli
    2)  els actors/actrius que hi actuen,
        taula: ACT
        camp : ACT.nom_actor
          camp : ACT.id_actor
          camp : ACT.id_peli   
    3)  el paper que interpreten.
        taula: ACT_PELI
        camp : ACT_PELI.papel
          camp : ACT_PELI.id_peli
          camp : ACT_PELI.id_actor
    ACT_PELI
        id_peli + id_actor + papel
*/


/* Modifiquem el delimitador de sentències a // */
DELIMITER //

/* Canviem a la base de dades empresa per
** assegurar-nos que és la base de dades seleccionada. */
USE videoclub//

/* Procedim a esborrar el procediment que volem
** crear per assegurar-nos que el creem des de zero. */
DROP PROCEDURE IF EXISTS Act_03_Apartat_001//

CREATE PROCEDURE Act_03_Apartat_001(
     IN  pe_codi smallint
)

-- La clàusula BEGIN indica l'inici del procediment.
  BEGIN
-- A partir d'aquí desenvolupem el procediment en si.

-- Declaració de variables. Si cal.

  SELECT PELIS.titol_peli Titol,
         ACT_PELI.papel Paper,
         ACT.nom_actor Actor
  FROM   PELLICULES PELIS
     INNER JOIN ACTORS_PELLICULES ACT_PELI
        INNER JOIN ACTORS ACT
  ON  PELIS.id_peli=ACT_PELI.id_peli 
      AND  ACT_PELI.id_actor=ACT.id_actor
  WHERE PELIS.id_peli=pe_codi;

-- La clàusula END indica el final del procediment.
  END //

-- Tornem el delimitador de sentències a l'estàndard que és ;
DELIMITER ;

/*
mysql> call Act_03_Apartat_001(1);
+-------------+-------------------------+--------------+
| Titol       | Paper                   | Actor        |
+-------------+-------------------------+--------------+
| La busqueda | Benjamin Franklin Gates | Nicolas Cage |
| La busqueda | Abigail Chase           | Diane Kruger |
+-------------+-------------------------+--------------+
*/
