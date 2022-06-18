CREATE TABLE IF NOT EXISTS
invoice(id int(5) UNIQUE AUTO_INCREMENT NOT NULL,
	vehicle_id int(5) NOT NULL, 
	customer_id int(5) NOT NULL
	date_invoice datetime DEFAULT NOW(),
	state varchar(25) NOT NULL  DEFAULT 'not_paid' CHECK (state IN ('paid','not_paid')), 
	PRIMARY KEY (id),
	FOREIGN KEY (vehicle_id) REFERENCES vehicle(id),
	FOREIGN KEY (customer_id) REFERENCES customer(id));
