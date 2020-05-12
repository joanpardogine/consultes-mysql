/*
** Sobre la base de dades videoclub.
** Activitat 2: Dissenya un procediment que torni,
** en un paràmetre global, el codi de la pel·lícula
** que més ha recaptat.
** Nom: PardoJoan_Act_03_ProcEmm_MySQL_Apartat_002.sql
** Paràmetres:
**    Entrada:
**        cap
**    Sortida:
**        po_codipeli_maxRecaptacio (smallint)
**    Global:
**        codi de la pel·lícula que més ha recaptat
**            --> id_peli (smallint)
**    Locals:
**        pl_maxRecaptacio (smallint)

Type      Bytes     Minimum     Maximum Maximum Value Unsigned
--------- ----- ----------- ----------- ----------------------
TINYINT     1          -128	        127    0               255
SMALLINT    2        -32768	      32767    0             65535
MEDIUMINT   3      -8388608	    8388607    0          16777215
INT         4	  -2147483648	 2147483647    0        4294967295
BIGINT      8	        -2^63	     2^63-1    0            2^64-1

mysql> SELECT max(recaudacio_peli)
    -> FROM PELLICULES;
+----------------------+
| max(recaudacio_peli) |
+----------------------+
|           1519557910 |
+----------------------+

mysql> SELECT id_peli
    -> FROM PELLICULES
    -> WHERE recaudacio_peli = 1519557910;
+---------+
| id_peli |
+---------+
|       8 |
+---------+
*/

-- Modifiquem el delimitador de sentències a //
DELIMITER //

/* Canviem a la base de dades videoclub per
*  assegurar-nos que és la base de dades seleccionada. */
USE videoclub//

/* Procedim a esborrar el procediment que volem
*  crear per assegurar-nos que el creem des de zero. */
DROP PROCEDURE IF EXISTS PardoJoan_Act_03_ProcEmm_MySQL_Apartat_002//

/* Procedim a crear el nou procediment amb la 
** clàusula CREATE PROCEDURE seguida del nom del procediment
** i la definició de paràmetres si cal. En aquest cas
** creem un paràmetre de sortida (OUT) que anomenem
** po_codipeli_maxRecaptacio (codi de pel·lícula - id_peli) que és el tipus smallint. */
CREATE DEFINER PROCEDURE PardoJoan_Act_03_ProcEmm_MySQL_Apartat_002(
 OUT po_codipeli_maxRecaptacio smallint)

-- La clàusula BEGIN indica l'inici del procediment.
  BEGIN

-- A partir d'aquí desenvolupem el procediment en si.
    DECLARE pl_maxRecaptacio bigint;
    SELECT max(recaudacio_peli)
      INTO pl_maxRecaptacio
    FROM PELLICULES;

    SELECT id_peli
      INTO po_codipeli_maxRecaptacio
    FROM PELLICULES
    WHERE recaudacio_peli = pl_maxRecaptacio;

-- La clàusula END indica el final del procediment.
  END //

-- Modifiquem el delimitador de sentències a l'estàndard que és ;
DELIMITER ;
