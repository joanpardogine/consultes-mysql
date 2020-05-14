/*
** Sobre la base de dades videoclub.
** Actiitat 4: Dissenya un procediment que rebi un codi
** de pel·lícula i torni com a paràmetre global el codi
** del seu actor principal.
** Nom: PardoJoan_Act_03_ProcEmm_MySQL_Apartat_004.sql
** Paràmetres:
**    Entrada: codi de pel·lícula
**              <-- ACTORS_PELLICULES.id_peli (smallint)
**        pe_codi
**    Sortida:
**        cap
**    Global:
**        el codi del seu actor principal ACTORS_PELLICULES.id_actor
**              --> pg_codi_prota (smallint)
** mysql> show tables;
+---------------------+
| Tables_in_videoclub |
+---------------------+
| ACTORS_PELLICULES   |
+---------------------+
**    mysql> desc ACTORS_PELLICULES;
+-----------+----------------------+------+-----+---------+-------+
| Field     | Type                 | Null | Key | Default | Extra |
+-----------+----------------------+------+-----+---------+-------+
| id_peli   | smallint(5) unsigned | NO   | PRI | 0       |       |
| id_actor  | smallint(5) unsigned | NO   | PRI | 0       |       |
| papel     | varchar(40)          | YES  |     | NULL    |       |
| principal | tinyint(1)           | YES  |     | NULL    |       |
+-----------+----------------------+------+-----+---------+-------+

** Farem servir les taules:
**    ACTORS_PELLICULES   ACT_PELI

mostri per pantalla:
    1)  res
*/


/*
SELECT *
FROM ACTORS_PELLICULES
WHERE principal=1 AND id_peli=1; // <-- pe_codi
+---------+----------+-------------------------+-----------+
| id_peli | id_actor | papel                   | principal |
+---------+----------+-------------------------+-----------+
|       1 |        1 | Benjamin Franklin Gates |         1 |
+---------+----------+-------------------------+-----------+


SELECT id_peli Peli, id_actor Prota
FROM ACTORS_PELLICULES
WHERE principal=1 AND id_peli=1;   <-- pe_codi 

+------+-------+
| Peli | Prota |
+------+-------+
|    1 |     1 |
+------+-------+
*/

-- Modifiquem el delimitador de sentències a //
DELIMITER //

/* Canviem a la base de dades videoclub per
*  assegurar-nos que és la base de dades seleccionada. */
USE videoclub//

/* Procedim a esborrar el procediment que volem
*  crear per assegurar-nos que el creem des de zero. */
DROP PROCEDURE IF EXISTS PardoJoan_Act_03_ProcEmm_MySQL_Apartat_004//

/* Procedim a crear el nou procediment amb la 
** clàusula CREATE PROCEDURE seguida del nom del procediment
** i la definició de paràmetres si cal. En aquest cas
** creem un paràmetre d'entrada (IN) que anomenem
** pe_codi (codi de pel·lícula - id_peli) que és el tipus smallint. */
CREATE PROCEDURE PardoJoan_Act_03_ProcEmm_MySQL_Apartat_004(
    IN pe_codi smallint)

-- La clàusula BEGIN indica l'inici del procediment.
  BEGIN

-- A partir d'aquí desenvolupem el procediment en si.
	DECLARE pg_codi_prota smallint;
	DECLARE pg_codi_peli smallint;

  SELECT id_peli, id_actor
      INTO pg_codi_peli, @pg_codi_prota
  FROM ACTORS_PELLICULES
  WHERE principal=1 AND id_peli=pe_codi; -- pe_codi 

-- La clàusula END indica el final del procediment.
  END //

-- Modifiquem el delimitador de sentències a l'estàndard que és ;
DELIMITER ;

-- call PardoJoan_Act_03_ProcEmm_MySQL_Apartat_004(1);
-- SELECT @pg_codi_prota;

