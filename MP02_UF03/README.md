# Activitat 1: Usuaris i privilegis en MySQL.

[MP02_UF03_Act_01_UsuPri_MySQL.pdf](./documents/MP02_UF03_Act_01_UsuPri_MySQL.pdf)

&nbsp;&nbsp;**1.** Crea un usuari nou amb el teu **`cognomnom`** en el servidor local.

&nbsp;&nbsp;**2.** Proporciona els permisos per la BD **`videoclub`** al nou usuari:

&nbsp;&nbsp;&nbsp;&nbsp;**a.** Llistar dades.

&nbsp;&nbsp;&nbsp;&nbsp;**b.** Inserir dades.

&nbsp;&nbsp;&nbsp;&nbsp;**c.** Modificar dades.

&nbsp;&nbsp;&nbsp;&nbsp;**d.** Esborrar dades.

&nbsp;&nbsp;&nbsp;&nbsp;**e.** Executar funcions.

&nbsp;&nbsp;**3.** Aplica els privilegis.

&nbsp;&nbsp;**4.** Mostra els privilegis del nou usuari.

&nbsp;&nbsp;**5.** Crea un usuari nou amb el teu **`cognomnom_admin`**.

&nbsp;&nbsp;**6.** Proporciona tots els privilegis per la BD **`videoclub`** a l’usuari creat
en l'**`apartart 5`**`.

&nbsp;&nbsp;**7.** Esborra el privilegi de crear taules a l’usuari creat en l'**`apartart 5`**.

&nbsp;&nbsp;**8.** Aplica els privilegis.

&nbsp;&nbsp;**9.** Mostra els privilegis de l’usuari creat en l'**`apartart 5`**.

&nbsp;&nbsp;**10.** Surt del MySQL i accedeix amb l’usuari creat en l'**`apartart 1`**.

&nbsp;&nbsp;**11.** Llista totes les pel·lícules.

&nbsp;&nbsp;&nbsp;&nbsp;**a.** Pots fer-ho?

&nbsp;&nbsp;&nbsp;&nbsp;**b.** En cas negatiu, per què?

&nbsp;&nbsp;**12.** Llistat tots els empleats de la BD **`empresa`**.

&nbsp;&nbsp;&nbsp;&nbsp;**a.** Pots fer-ho?

&nbsp;&nbsp;&nbsp;&nbsp;**b.** En cas negatiu, per què?

&nbsp;&nbsp;**13.** Esborra l’usuari creat en l'**`apartart 5`**.


&nbsp;&nbsp;Creeu un fitxer sql amb el resultat de cada apartat. Per exemple, el nom del fitxer que
conté la solució a l'**`apartart 1`** serà:

&nbsp;&nbsp;**`CognomNom_Act_01_UsuPri_MySQL_Apartat_001.sql`**
&nbsp;&nbsp;I el lliurament, serà un fitxer comprimit (**`zip`**, o **`rar`**) que contindrà tots els fitxers sql de cadascun dels apartats.

&nbsp;&nbsp;**`CognomNom_Act_01_UsuPri_MySQL.zip`**

&nbsp;&nbsp;Recordeu que la correcció la faré pujant el fitxer que m'enviïs i executant-lo directament
al meu servidor. Per tant, sabreu si em funcionarà o no, si executant-lo vosaltres en el
vostre servidor funciona o no.

# Activitat 2: Treballadors amb fills.
# Activitat 3: Activitats de procediments emmagatzemats 
# Activitat 4: Activitats de SP amb cursors


# Enunciats per practicar amb els `INSERT`'s
![MER_Videoclub](./imatges/MER_Videoclub.png)


**1.** Emprant la base de dades **`videoclub`**, cal que:
Insertis, com a mínim **tres** registres, a **totes** i cadascuna de les **taules** que existeixen a la base de dades de **`videoclub`**.


~~~~sql
+---------------------+
| Taules a videoclub  |
+---------------------+
| ACTORS              |
| ACTORS_PELLICULES   |
| DIRECTORS           |
| EXEMPLARS           |
| PELLICULES          |
| PRESTECS            |
| SOCIS               |
+---------------------+
~~~~
La informació de cada pel·lícula cal que la obtingeu de la web [IMDb.com](https://www.imdb.com/). ![logoIMDb](https://upload.wikimedia.org/wikipedia/commons/thumb/6/69/IMDB_Logo_2016.svg/245px-IMDB_Logo_2016.svg.png)
