/* Vérifier si tous les alim_code dans la table COMPO existent dans la table ALIM :
Check if all the alim_codes in the COMPO table exist in the ALIM table: */

SELECT alim_code FROM COMPO
WHERE alim_code NOT IN (SELECT alim_code FROM ALIM);

/* Vérifier si tous les const_code dans la table COMPO existent dans la table CONST :
Check if all const_codes in the COMPO table exist in the CONST table: */

SELECT const_code FROM COMPO
WHERE const_code NOT IN (SELECT const_code FROM CONST);

/* Vérifier si tous les source_code dans la table COMPO existent dans la table SOURCES :
Check if all source_codes in the COMPO table exist in the SOURCES table: */

SELECT source_code FROM COMPO
WHERE source_code NOT IN (SELECT source_code FROM SOURCES);

/* Vérifier si tous les codes de groupe, sous-groupe et sous-sous-groupe dans la table ALIM existent dans la table ALIM_GRP :
Check if all group, subgroup and sub-subgroup codes in the ALIM table exist in the ALIM_GRP table: */

SELECT alim_code, alim_grp_code, alim_ssgrp_code, alim_ssssgrp_code FROM ALIM
WHERE (alim_grp_code, alim_ssgrp_code, alim_ssssgrp_code) NOT IN (
    SELECT alim_grp_code, alim_ssgrp_code, alim_ssssgrp_code FROM ALIM_GRP
);

/* Si l'une de ces requêtes renvoie des résultats, cela signifie qu'il y a des problèmes d'intégrité dans votre base de données
If any of these queries return results, it means that there are integrity problems in your database */