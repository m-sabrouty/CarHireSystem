CREATE TABLE IF NOT EXISTS
vehicle(id int(5) UNIQUE AUTO_INCREMENT NOT NULL,
	name varchar(25) NOT NULL, 
	category varchar(25) NOT NULL CHECK (category IN ('small','family','van')), 
	PRIMARY KEY (id));
