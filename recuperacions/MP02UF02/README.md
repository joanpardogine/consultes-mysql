# Recuperacions MP02: UF02 Llenguatges SQL: DML i DDL

La recuperació es basarà a realitzar les següents consultes SQL.

#### &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Sobre la base de dades **empresa**

1. Retornar el nom i la data d'alta dels treballadors que han estat donat d'alta durant el 2011, fent servir la funció ```year()```
1. Mostrar el nom i l'ofici, dels treballadors que son Venedors, Analistes o Director.
1. Mostrar el nom i el sou dels treballadors que tenen el sou més alt i el més baix de tots els sous.
1. Mostrar el nom dels treballadors que tenen responsable (cap).
1. Mostrar el nom dels articles que son de tennis. És a dir que tenen la paraula **tennis** a la seva descripció.
1. Mostra totes les taules que hi ha a la base de dades.
1. Mostra la suma del sou de tots els treballadors agrupats per departament.

    #### I sobre la base de dades **videoclub**
1. Fes una cosulta que mostri per pantalla el **nom de la pel·lícula** (***PELLICULES.titol_peli***) els **actors**/**actrius** (***ACTORS.nom_actor***) que hi actuen i el **paper** que interpreten (***ACTORS_PELLICULES.papel***). Es necessari que facis un **```INNER JOIN```** de les taules **PELLICULES**, **ACTORS** i **ACTORS_PELLICULES**.

Recorda la sintaxi:

```sql
SELECT taula_1.camp_taula_1, taula_2.camp_taula_2, taula_3.camp_taula_3
FROM taula_1
  JOIN taula_2
    ON taula_1.camp_taula_1 = taula_2.camp_taula_2
  JOIN taula_3
    ON taula_1.camp_taula_2 = taula_3.camp_taula_3
```
