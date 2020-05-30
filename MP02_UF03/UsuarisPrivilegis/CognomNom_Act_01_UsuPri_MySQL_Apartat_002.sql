/ * 
2. Proporciona els permisos per la BD videoclub al nou usuari:
  a. Llistar dades.
  b. Inserir dades.
  c. Modificar dades.
  d. Esborrar dades.
  e. Executar funcions.
Fitxer: CognomNom_Act_01_UsuPri_MySQL_Apartat_002.sql
*/

GRANT SELECT,INSERT,UPDATE,DELETE,EXECUTE
ON    videoclub
FOR 'pardojoan'@'localhost';
