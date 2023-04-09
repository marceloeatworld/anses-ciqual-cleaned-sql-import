import pymysql
import xml.etree.ElementTree as ET

# Remplacez ces valeurs par vos propres informations d'identification et le nom de la base de données
host = 'localhost'
user = 'user'
password = 'password'
database = 'dbname'

# Connexion à la base de données
connection = pymysql.connect(
    host=host,
    user=user,
    password=password,
    database=database
)

cursor = connection.cursor()

# Fonction pour lire les données XML et les insérer dans la base de données
def process_xml_file(file_name, table_name, columns, check_column):
    tree = ET.parse(file_name, parser=ET.XMLParser(encoding="UTF-8"))
    root = tree.getroot()

    line_number = 0  # initialiser le compteur de lignes
    for record in root:
        line_number += 1  # incrémenter le compteur de lignes

        values = []
        for col in columns:
            element = record.find(col)
            if element is not None and element.text is not None:
                value = element.text.strip().encode('utf-8')
            else:
                value = ''
            if col == 'min' or col == 'max':
               value = value.strip()
               if value == '':
                   value = None
            values.append(value)

        check_query = f"SELECT * FROM {table_name} WHERE {check_column} = %s"
        try:
            cursor.execute(check_query, (values[0],))
            result = cursor.fetchone()
            if result is None:
                query = f"INSERT INTO {table_name} ({', '.join(columns)}) VALUES ({', '.join(['%s'] * len(columns))})"
                cursor.execute(query, values)
                connection.commit()
            else:
                print(f"Record with {check_column}={values[0]} already exists in table {table_name}")
        except Exception as e:
            print(f"Error on line {line_number}: {str(e)}")
            break


# Insérer des données dans la base de données à partir des fichiers XML
process_xml_file('sources_utf8.xml', 'SOURCES', ['source_code', 'ref_citation'], 'source_code')
process_xml_file('const_utf8.xml', 'CONST', ['const_code', 'const_nom_fr', 'const_nom_eng'], 'const_code')
process_xml_file('alim_grp_utf8.xml', 'ALIM_GRP', ['alim_grp_code', 'alim_grp_nom_fr', 'alim_grp_nom_eng', 'alim_ssgrp_code', 'alim_ssgrp_nom_fr', 'alim_ssgrp_nom_eng', 'alim_ssssgrp_code', 'alim_ssssgrp_nom_fr', 'alim_ssssgrp_nom_eng'], 'alim_grp_code')
process_xml_file('alim_utf8.xml', 'ALIM', ['alim_code', 'alim_nom_fr', 'ALIM_NOM_INDEX_FR', 'alim_nom_eng', 'alim_grp_code', 'alim_ssgrp_code', 'alim_ssssgrp_code'], 'alim_code')
process_xml_file('compo_utf8.xml', 'COMPO', ['alim_code', 'const_code', 'teneur', 'min', 'max', 'code_confiance', 'source_code'], 'alim_code')
# Fermeture de la connexion à la base de données
cursor.close()
connection.close()
