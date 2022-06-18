CREATE TABLE IF NOT EXISTS
email(id int(5) UNIQUE AUTO_INCREMENT NOT NULL,
	email varchar(25) NOT NULL,
	body varchar(300) NOT NULL, 
	date_email datetime DEFAULT NOW(), 
	PRIMARY KEY (id));
