/*
** Sobre la base de dades videoclub.
** Actiitat 3: Dissenya un procediment que torni en
** paràmetres globals el títol i recaudació de la
** pel·lícula que més ha recaudat.
** Nom: PardoJoan_Act_03_ProcEmm_MySQL_Apartat_003.sql
** Paràmetres:
**    Entrada:
**        cap
**    Sortida:
**        OUT id_peli smallint
** mysql> show tables;
+---------------------+
| Tables_in_videoclub |
+---------------------+
| PELLICULES          |
+---------------------+
**    mysql> desc PELLICULES;
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

** Farem servir les taules:
**    PELLICULES          PELIS


mostri per pantalla:
    1)  codi de la pel·lícula que més ha recaudat!!
        taula: PELLICULES
        camp : PELLICULES.id_peli
*/

-- Modifiquem el delimitador de sentències a //
DELIMITER //

/* Canviem a la base de dades videoclub per
*  assegurar-nos que és la base de dades seleccionada. */
USE videoclub//

/* Procedim a esborrar el procediment que volem
*  crear per assegurar-nos que el creem des de zero. */
DROP PROCEDURE IF EXISTS PardoJoan_Act_03_ProcEmm_MySQL_Apartat_003//

/* Procedim a crear el nou procediment amb la 
** clàusula CREATE PROCEDURE seguida del nom del procediment
** i la definició de paràmetres si cal. En aquest cas
** creem un paràmetre de sortida (OUT) que anomenem
** pe_codi (codi de pel·lícula - id_peli) que és el tipus smallint. */
CREATE PROCEDURE PardoJoan_Act_03_ProcEmm_MySQL_Apartat_003()

-- La clàusula BEGIN indica l'inici del procediment.
  BEGIN

-- A partir d'aquí desenvolupem el procediment en si.
	DECLARE pg_codipeli_maxRecau bigint;
	DECLARE pg_nompeli_maxRecau bigint;
  DECLARE max_recaudacio bigint;
  
  SELECT MAX(recaudacio_peli)
    INTO max_recaudacio
  FROM PELLICULES;

  SELECT id_peli, titol_peli
    INTO @pg_codipeli_maxRecau, @pg_nompeli_maxRecau
	FROM PELLICULES
	WHERE recaudacio_peli = max_recaudacio;

-- La clàusula END indica el final del procediment.
  END //

-- Modifiquem el delimitador de sentències a l'estàndard que és ;
DELIMITER ;

-- call PardoJoan_Act_03_ProcEmm_MySQL_Apartat_003;
-- SELECT @pg_codipeli_maxRecau, @pg_nompeli_maxRecau;

