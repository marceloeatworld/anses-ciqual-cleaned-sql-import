CREATE TABLE SOURCES (
    source_code INT PRIMARY KEY,
    ref_citation VARCHAR(255)
);

CREATE TABLE CONST (
    const_code INT PRIMARY KEY,
    const_nom_fr VARCHAR(255),
    const_nom_eng VARCHAR(255)
);

CREATE TABLE ALIM_GRP (
    alim_grp_code VARCHAR(10),
    alim_grp_nom_fr VARCHAR(255),
    alim_grp_nom_eng VARCHAR(255),
    alim_ssgrp_code VARCHAR(10),
    alim_ssgrp_nom_fr VARCHAR(255),
    alim_ssgrp_nom_eng VARCHAR(255),
    alim_ssssgrp_code VARCHAR(10),
    alim_ssssgrp_nom_fr VARCHAR(255),
    alim_ssssgrp_nom_eng VARCHAR(255),
    PRIMARY KEY (alim_grp_code, alim_ssgrp_code, alim_ssssgrp_code)
);

CREATE TABLE ALIM (
    alim_code INT PRIMARY KEY,
    alim_nom_fr VARCHAR(255),
    ALIM_NOM_INDEX_FR VARCHAR(255),
    alim_nom_eng VARCHAR(255),
    alim_grp_code VARCHAR(10),
    alim_ssgrp_code VARCHAR(10),
    alim_ssssgrp_code VARCHAR(10),
    FOREIGN KEY (alim_grp_code, alim_ssgrp_code, alim_ssssgrp_code) REFERENCES ALIM_GRP(alim_grp_code, alim_ssgrp_code, alim_ssssgrp_code)
);

CREATE TABLE COMPO (
    alim_code INT,
    const_code INT,
    teneur DECIMAL(10,2),
    min DECIMAL(10,2),
    max DECIMAL(10,2),
    code_confiance CHAR(1),
    source_code INT,
    PRIMARY KEY (alim_code, const_code),
    FOREIGN KEY (alim_code) REFERENCES ALIM(alim_code),
    FOREIGN KEY (const_code) REFERENCES CONST(const_code),
    FOREIGN KEY (source_code) REFERENCES SOURCES(source_code)
);
