USE magist;
/* 
Expand the database
	Find online a dataset that contains the abbreviations for the Brazilian states and the full names of the states. 
It does not need to contain any other information about the states, but it is ok if it does.
	#Import the dataset as an SQL table in the Magist database.
    -- truncate the table first
	##Create the appropriate relationships with other tables in the database.
*/    
show global variables like 'local_infile';
set global local_infile=true;
 
LOAD DATA LOCAL INFILE 'C:\Users\icaro\Documents\WBS_Coding_School\9-SQL\BR_states.csv' 
INTO TABLE BR_states 
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\n';
#IGNORE 1 ROWS;

DROP TABLE BR_states;
CREATE TABLE BR_states(
   #BR_id               INTEGER  NOT NULL PRIMARY KEY ,
   UF                  VARCHAR(2) NOT NULL PRIMARY KEY
  ,State               VARCHAR(19) NOT NULL 
  ,Capital             VARCHAR(14) NOT NULL
  ,Region              VARCHAR(11) NOT NULL
  ,Area                NUMERIC(11,3) NOT NULL
  ,Population          INTEGER  NOT NULL
  ,Demographic_Density NUMERIC(6,2) NOT NULL
  ,Cities_count        INTEGER  NOT NULL
  ,GDP                 NUMERIC(8,2) NOT NULL
  ,GDP_rate            NUMERIC(3,1) NOT NULL
  ,Poverty             NUMERIC(5,3) NOT NULL
  ,Latitude            NUMERIC(6,2) NOT NULL
  ,Longitude           NUMERIC(6,2) NOT NULL
);
-- Inserting data in the table
INSERT INTO BR_states(UF,State,Capital,Region,Area,Population,Demographic_Density,Cities_count,GDP,GDP_rate,Poverty,Latitude,Longitude) VALUES ('AC','Acre','Rio Branco','North',164123.738,881935,5.37,22,17201.95,0.5,0.189,-8.77,-70.55);
INSERT INTO BR_states(UF,State,Capital,Region,Area,Population,Demographic_Density,Cities_count,GDP,GDP_rate,Poverty,Latitude,Longitude) VALUES ('AL','Alagoas','Maceió','Northeast',27843.295,3337357,119.86,102,15653.51,0.5,0.205,-9.62,-36.82);
INSERT INTO BR_states(UF,State,Capital,Region,Area,Population,Demographic_Density,Cities_count,GDP,GDP_rate,Poverty,Latitude,Longitude) VALUES ('AM','Amazonas','Manaus','North',1559168.117,4144597,2.66,62,22936.28,0.7,0.193,-3.47,-65.1);
INSERT INTO BR_states(UF,State,Capital,Region,Area,Population,Demographic_Density,Cities_count,GDP,GDP_rate,Poverty,Latitude,Longitude) VALUES ('AP','Amapá','Macapá','North',142470.762,845731,5.94,16,19405.11,0.6,0.128,1.41,-51.77);
INSERT INTO BR_states(UF,State,Capital,Region,Area,Population,Demographic_Density,Cities_count,GDP,GDP_rate,Poverty,Latitude,Longitude) VALUES ('BA','Bahia','Salvador','Northeast',564722.611,14873064,26.34,417,17508.67,0.6,0.177,-13.29,-41.71);
INSERT INTO BR_states(UF,State,Capital,Region,Area,Population,Demographic_Density,Cities_count,GDP,GDP_rate,Poverty,Latitude,Longitude) VALUES ('CE','Ceará','Fortaleza','Northeast',148894.757,9132078,61.33,184,16394.99,0.5,0.184,-5.2,-39.53);
INSERT INTO BR_states(UF,State,Capital,Region,Area,Population,Demographic_Density,Cities_count,GDP,GDP_rate,Poverty,Latitude,Longitude) VALUES ('DF','Distrito Federal','Brasília','Center-west',5760.783,3015268,523.41,1,80502.47,2.5,0.019,-15.83,-47.86);
INSERT INTO BR_states(UF,State,Capital,Region,Area,Population,Demographic_Density,Cities_count,GDP,GDP_rate,Poverty,Latitude,Longitude) VALUES ('ES','Espírito Santo','Vitória','Southeast',46074.444,4018650,87.22,78,28222.56,0.9,0.043,-19.19,-40.34);
INSERT INTO BR_states(UF,State,Capital,Region,Area,Population,Demographic_Density,Cities_count,GDP,GDP_rate,Poverty,Latitude,Longitude) VALUES ('GO','Goiás','Goiânia','Center-west',340125.715,7018354,20.63,246,28308.77,0.9,0.037,-15.98,-49.86);
INSERT INTO BR_states(UF,State,Capital,Region,Area,Population,Demographic_Density,Cities_count,GDP,GDP_rate,Poverty,Latitude,Longitude) VALUES ('MA','Maranhão','São Luís','Northeast',329642.17,7075181,21.46,217,12788.75,0.4,0.263,-5.42,-45.44);
INSERT INTO BR_states(UF,State,Capital,Region,Area,Population,Demographic_Density,Cities_count,GDP,GDP_rate,Poverty,Latitude,Longitude) VALUES ('MG','Minas Gerais','Belo Horizonte','Southeast',586521.121,21168791,36.09,853,27282.75,0.9,0.047,-18.1,-44.38);
INSERT INTO BR_states(UF,State,Capital,Region,Area,Population,Demographic_Density,Cities_count,GDP,GDP_rate,Poverty,Latitude,Longitude) VALUES ('MS','Mato Grosso do Sul','Campo Grande','Center-west',357145.535,2778986,7.78,79,35520.45,1.1,0.05,-20.51,-54.54);
INSERT INTO BR_states(UF,State,Capital,Region,Area,Population,Demographic_Density,Cities_count,GDP,GDP_rate,Poverty,Latitude,Longitude) VALUES ('MT','Mato Grosso','Cuiabá','Center-west',903206.997,3484466,3.86,141,37914,1.2,0.059,-12.64,-55.42);
INSERT INTO BR_states(UF,State,Capital,Region,Area,Population,Demographic_Density,Cities_count,GDP,GDP_rate,Poverty,Latitude,Longitude) VALUES ('PA','Pará','Belém','North',1245759.305,8602865,6.91,144,18549.33,0.6,0.192,-3.79,-52.48);
INSERT INTO BR_states(UF,State,Capital,Region,Area,Population,Demographic_Density,Cities_count,GDP,GDP_rate,Poverty,Latitude,Longitude) VALUES ('PB','Paraíba','João Pessoa','Northeast',56467.239,4018127,71.16,223,15497.67,0.5,0.163,-7.28,-36.72);
INSERT INTO BR_states(UF,State,Capital,Region,Area,Population,Demographic_Density,Cities_count,GDP,GDP_rate,Poverty,Latitude,Longitude) VALUES ('PE','Pernambuco','Recife','Northeast',98068.021,9557071,97.45,185,19164.52,0.6,0.161,-8.38,-37.86);
INSERT INTO BR_states(UF,State,Capital,Region,Area,Population,Demographic_Density,Cities_count,GDP,GDP_rate,Poverty,Latitude,Longitude) VALUES ('PI','Piauí','Teresina','Northeast',251616.823,3273227,13.01,224,14089.78,0.4,0.216,-6.6,-42.28);
INSERT INTO BR_states(UF,State,Capital,Region,Area,Population,Demographic_Density,Cities_count,GDP,GDP_rate,Poverty,Latitude,Longitude) VALUES ('PR','Paraná','Curitiba','South',199305.236,11433957,57.37,399,37221,1.2,0.03,-24.89,-51.55);
INSERT INTO BR_states(UF,State,Capital,Region,Area,Population,Demographic_Density,Cities_count,GDP,GDP_rate,Poverty,Latitude,Longitude) VALUES ('RJ','Rio de Janeiro','Rio de Janeiro','Southeast',43750.423,17264943,394.62,92,40155.76,1.3,0.039,-22.25,-42.66);
INSERT INTO BR_states(UF,State,Capital,Region,Area,Population,Demographic_Density,Cities_count,GDP,GDP_rate,Poverty,Latitude,Longitude) VALUES ('RN','Rio Grande do Norte','Natal','Northeast',52809.602,3506853,66.41,167,18333.19,0.6,0.13,-5.81,-36.59);
INSERT INTO BR_states(UF,State,Capital,Region,Area,Population,Demographic_Density,Cities_count,GDP,GDP_rate,Poverty,Latitude,Longitude) VALUES ('RO','Rondônia','Porto Velho','North',237765.233,1777225,7.47,52,24092.81,0.8,0.079,-10.83,-63.34);
INSERT INTO BR_states(UF,State,Capital,Region,Area,Population,Demographic_Density,Cities_count,GDP,GDP_rate,Poverty,Latitude,Longitude) VALUES ('RR','Roraima','Boa Vista','North',224273.831,605761,2.7,15,23158.06,0.7,0.179,1.99,-61.33);
INSERT INTO BR_states(UF,State,Capital,Region,Area,Population,Demographic_Density,Cities_count,GDP,GDP_rate,Poverty,Latitude,Longitude) VALUES ('RS','Rio Grande do Sul','Porto Alegre','South',281707.151,11377239,40.39,497,37371.27,1.2,0.029,-30.17,-53.5);
INSERT INTO BR_states(UF,State,Capital,Region,Area,Population,Demographic_Density,Cities_count,GDP,GDP_rate,Poverty,Latitude,Longitude) VALUES ('SC','Santa Catarina','Florianópolis','South',95730.921,7164788,74.84,295,39592.28,1.2,0.017,-27.45,-50.95);
INSERT INTO BR_states(UF,State,Capital,Region,Area,Population,Demographic_Density,Cities_count,GDP,GDP_rate,Poverty,Latitude,Longitude) VALUES ('SE','Sergipe','Aracaju','Northeast',21926.908,2298696,104.83,75,17789.21,0.6,0.153,-10.57,-37.45);
INSERT INTO BR_states(UF,State,Capital,Region,Area,Population,Demographic_Density,Cities_count,GDP,GDP_rate,Poverty,Latitude,Longitude) VALUES ('SP','São Paulo','São Paulo','Southeast',248219.481,45919049,184.99,645,47008.77,1.5,0.027,-22.19,-48.79);
INSERT INTO BR_states(UF,State,Capital,Region,Area,Population,Demographic_Density,Cities_count,GDP,GDP_rate,Poverty,Latitude,Longitude) VALUES ('TO','Tocantins','Palmas','North',277720.404,1572866,5.66,139,21998.34,0.7,0.119,-9.46,-48.26);
		
-- Testing the connection
SELECT * 
FROM br_states,
	(SELECT city
	FROM geo
	) As geo_cidade
;

/*
Analyze customer reviews
Find the average review score by state of the customer.
Do reviews containing positive words have a better score? Some Portuguese positive words are: “bom”, “otimo”, 
“gostei”, “recomendo” and “excelente”.
Considering only states having at least 30 reviews containing these words, what is the state with the highest score?
What is the state where there is a greater score change between all reviews and reviews containing positive words?
Automatize a KPI
Create a stored procedure that gets as input:

The name of a state (the full name from the table you imported).
The name of a product category (in English).
A year
And outputs the average score for reviews left by customers from the given state for orders with the status “delivered, 
containing at least a product in the given category, and placed on the given year.
*/
