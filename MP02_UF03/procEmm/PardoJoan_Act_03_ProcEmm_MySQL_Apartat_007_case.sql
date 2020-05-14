/*
7.Dissenya un procediment que rebi el codi d’un actor/actriu i torni:
a)  El nom i cognoms.
b)  L’edat: diferència entre l'any actual (year(curdate()) i el seu any de naixement.
c)  Sexe.
d)  Tipus de paper que pot interpretar:

 --  Si és home:
*) Menor de 15 anys: nen.
*) Entre 15 i 25 anys: home adolescent i jove.
*) Entre  26 i 40 anys: home adult.
*) Entre 41 i 60 anys: home madur.
*) Més de 61 anys: home gran.

---Si és dona:
*) Menor de 15 anys: nena.
*) Entre 15 i 25 anys: dona adolescent i jove.
*) Entre  26 i 40 anys: dona adulta.
*) Entre 41 i 60 anys: dona madur.
*) Més de 61 anys: dona gran.


** Nom: PardoJoan_Act_03_ProcEmm_MySQL_Apartat_007_case.sql
** Paràmetres:
**    Entrada:
**        pi_actor smallint  (id_actor)
**    Sortida:
**        cap
** Mostrarà el a + b + c + paper que pot interpretar
a = nom_actor
b = edat = (year(curdate()) - anynaix_actor
c = sexe_actor

SI sexe_actor = home
  SI edat<15 LLAVORS                            missatge = nen
  SINOSI edat<=15 AND edat<=25 LLAVORS          missatge = home adolescent i jove
    SINOSI edat<=26 AND edat<=40 LLAVORS        missatge = home adult
      SINOSI edat<=41 AND edat<=60 LLAVORS      missatge = home madur
        SINOSI edat>=60 LLAVORS                 missatge = home gran
  FISI
ELSE  // sexe_actor = dona
  SI edat<15 LLAVORS                            missatge = nena
  SINOSI edat<=15 AND edat<=25 LLAVORS          missatge = dona adolescent i jove
    SINOSI edat<=26 AND edat<=40 LLAVORS        missatge = dona adulta
      SINOSI edat<=41 AND edat<=60 LLAVORS      missatge = dona madura
        SINOSI edat>=60 LLAVORS                 missatge = dona gran
  FISI
FISI

mysql> desc ACTORS;
+---------------+----------------------+------+-----+---------+-------+
| Field         | Type                 | Null | Key | Default | Extra |
+---------------+----------------------+------+-----+---------+-------+
| id_actor      | smallint(5) unsigned | NO   | PRI | NULL    |       |
| nom_actor     | varchar(30)          | YES  | MUL | NULL    |       |
| nacio_actor   | varchar(20)          | YES  |     | NULL    |       |
| anynaix_actor | smallint(5) unsigned | YES  |     | NULL    |       |
| sexe_actor    | varchar(6)           | YES  |     | NULL    |       |
+---------------+----------------------+------+-----+---------+-------+
*/

/* Modifiquem el delimitador de sentències a // */

DELIMITER //

/* Canviem a la base de dades empresa per
** assegurar-nos que és la base de dades seleccionada. */
USE videoclub//

/* Procedim a esborrar el procediment que volem
** crear per assegurar-nos que el creem des de zero. */
DROP PROCEDURE IF EXISTS PardoJoan_Act_03_ProcEmm_MySQL_Apartat_007_case//

CREATE PROCEDURE PardoJoan_Act_03_ProcEmm_MySQL_Apartat_007_case(
 IN  pi_actor       smallint)
-- La clàusula BEGIN indica l'inici del procediment.

  BEGIN
-- A partir d'aquí desenvolupem el procediment en si.

-- Declaració de variables. Si cal.
   DECLARE pa_nomActor       varchar(30);
   DECLARE pa_edatActor      smallint;
   DECLARE pa_sexeActor      varchar(6);
   DECLARE pa_paper          varchar(50);

SELECT nom_actor, year(curdate())-anynaix_actor, sexe_actor
   INTO pa_nomActor, pa_edatActor, pa_sexeActor
FROM   ACTORS
WHERE  id_actor=pi_actor; 

/*
SI sexe_actor = home
  SI edat<15 LLAVORS                            missatge = nen
  SINOSI edat<=15 AND edat<=25 LLAVORS          missatge = home adolescent i jove
    SINOSI edat<=26 AND edat<=40 LLAVORS        missatge = home adult
      SINOSI edat<=41 AND edat<=60 LLAVORS      missatge = home madur
        SINOSI edat>=60 LLAVORS                 missatge = home gran
  FISI
ELSE  // sexe_actor = dona
  SI edat<15 LLAVORS                            missatge = nena
  SINOSI edat<=15 AND edat<=25 LLAVORS          missatge = dona adolescent i jove
    SINOSI edat<=26 AND edat<=40 LLAVORS        missatge = dona adulta
      SINOSI edat<=41 AND edat<=60 LLAVORS      missatge = dona madura
        SINOSI edat>=60 LLAVORS                 missatge = dona gran
  FISI
FISI
*/


CASE
  WHEN   pa_edatActor < 15 THEN
      IF pa_sexeActor = home THEN
       SET   pa_paper = "de nen";
      ELSE
       SET   pa_paper = "de nena";
     END IF;
      
  WHEN   pa_edatActor < 25 THEN
      IF pa_sexeActor = home THEN
        SET pa_paper = "d'home adolescent i jove";
      ELSE
       SET pa_paper = "de dona adolescent i jove";
     END IF;
     
  WHEN   pa_edatActor < 40 THEN
      IF pa_sexeActor = home THEN
        SET pa_paper = "d'home adult";
      ELSE
       SET   pa_paper = "de dona adulta";
     END IF;
     
  WHEN   pa_edatActor < 60 THEN
      IF pa_sexeActor = home THEN
        SET pa_paper = "d'home madur";
      ELSE
        SET   pa_paper = "de dona madura";
     END IF;
     
  WHEN   pa_edatActor >= 60  THEN
      IF pa_sexeActor = home THEN
        SET pa_paper = "d'home gran";
      ELSE
       SET   pa_paper = "de dona gran";
     END IF;
     
END CASE;
  
/*
mysql> call PardoJoan_Act_03_ProcEmm_MySQL_Apartat_007_case(1);
+------------------------------------------------------+
| Frase                                                |
+------------------------------------------------------+
| L'actor Nicolas Cage té 56 i pot fer de home madur.  |
+------------------------------------------------------+
*/
  
-- La clàusula END indica el final del procediment.
  END //

-- Tornem el delimitador de sentències a l'estàndard que és ;
DELIMITER ;


