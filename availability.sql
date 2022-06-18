CREATE TABLE IF NOT EXISTS
availability(id int(5) UNIQUE AUTO_INCREMENT NOT NULL,
	vehicle_id int(5) NOT NULL, 
	is_available boolean NOT NULL DEFAULT true, 
	date_available datetime DEFAULT NOW(),
	PRIMARY KEY (id),
	FOREIGN KEY (vehicle_id) REFERENCES vehicle(id));
