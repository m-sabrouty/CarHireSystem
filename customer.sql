CREATE TABLE IF NOT EXISTS
customer(id int(5) UNIQUE AUTO_INCREMENT NOT NULL,
	name varchar(25), 
	phone varchar(25), 
	email varchar(25) NOT NULL CONSTRAINT email_validation
    CHECK ( email REGEXP "^[a-zA-Z0-9][a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]*?[a-zA-Z0-9._-]?@[a-zA-Z0-9][a-zA-Z0-9._-]*?[a-zA-Z0-9]?\\.[a-zA-Z]{2,63}$"), 
	PRIMARY KEY (id));
