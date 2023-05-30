/* Requête pour vérifier si tous les alim_code de COMPO existent dans ALIM : */

SELECT alim_code FROM COMPO
WHERE alim_code NOT IN (SELECT alim_code FROM ALIM);

/* Requête pour vérifier si tous les const_code de COMPO existent dans CONST : */

SELECT const_code FROM COMPO
WHERE const_code NOT IN (SELECT const_code FROM CONST);

/* Requête pour vérifier si tous les source_code de COMPO existent dans SOURCES :*/

SELECT source_code FROM COMPO
WHERE source_code NOT IN (SELECT source_code FROM SOURCES);

/* Requête pour vérifier si tous les codes de ALIM existent dans ALIM_GRP : */

SELECT alim_code, alim_grp_code, alim_ssgrp_code, alim_ssssgrp_code FROM ALIM
WHERE (alim_grp_code, alim_ssgrp_code, alim_ssssgrp_code) NOT IN (
    SELECT alim_grp_code, alim_ssgrp_code, alim_ssssgrp_code FROM ALIM_GRP
);

/* Si une requête renvoie des résultats, cela signifie qu'il y a des problèmes d'intégrité dans la base de données.*/
