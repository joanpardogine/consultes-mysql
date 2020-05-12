DROP DATABASE IF EXISTS LLIBRERIA;

CREATE DATABASE LLIBRERIA;

USE LLIBRERIA;

DROP TABLE IF EXISTS LLIBRES;

 CREATE TABLE LLIBRES (
   CODI INT AUTO_INCREMENT,
   TITOL VARCHAR (40),
   AUTOR VARCHAR (30),
   EDITORIAL VARCHAR (20),
   PREU DECIMAL (5,2),
   ESTOC INT,
   PRIMARY KEY (CODI)
 );

INSERT INTO LLIBRES (TITOL, AUTOR, EDITORIAL, PREU, ESTOC)
VALUES ('Alícia al país de les meravelles', 'Lewis Carroll', 'EMECE', 20.00, 9),
('Alícia al país de les meravelles', 'Lewis Carroll', 'Plaça', 35.00, 50),
('Aprendre PHP', 'mario molina', 'Segle XXI', 40.00, 3),
('El aleph', 'Borges', 'EMECE', 10.00, 18),
('Il·lusions', 'Richard Bach', 'Planeta', 15.00, 22),
('Java en 10 minuts', 'Mario Molina', 'Segle XXI', 50.00, 7),
('Martin Fierro', 'Jose Hernandez', 'Planeta', 20.00, 3),
('Martin Fierro', 'Jose Hernandez', 'EMECE', 30.00, 70),
('Un', 'Richard Bach', 'Planeta', 10.00, 120);
