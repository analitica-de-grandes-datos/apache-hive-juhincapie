DROP TABLE IF EXISTS datos;
DROP TABLE IF EXISTS word_counts;
CREATE TABLE datos (
    letra STRING,
    fecha DATE,
    valor INT)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
TBLPROPERTIES ("skip.header.line.count"="0");

LOAD DATA LOCAL INPATH "data.tsv" OVERWRITE INTO TABLE datos;

CREATE TABLE word_counts AS SELECT letra, COUNT(1) AS cantidad FROM datos GROUP BY letra ORDER BY letra;

INSERT OVERWRITE LOCAL DIRECTORY './output'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
SELECT * FROM word_counts;
