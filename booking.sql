CREATE TABLE IF NOT EXISTS
booking(id int(5) UNIQUE AUTO_INCREMENT NOT NULL,
	date_hire datetime NOT NULL , 
	date_return datetime NOT NULL,
	date_booking datetime NOT NULL , 
	customer_id int(5) NOT NULL,
	vehicle_id int(5),
	invoice_id int(5),
	total_amount float(5),
	state varchar(25) NOT NULL DEFAULT 'confirmed' CHECK (state IN ('confirmed','in_progress','done')), 
	PRIMARY KEY (id),
	FOREIGN KEY (customer_id) REFERENCES customer(id),
	FOREIGN KEY (vehicle_id) REFERENCES vehicle(id),
	FOREIGN KEY (invoice_id) REFERENCES invoice(id)
);

DELIMITER //
CREATE TRIGGER insert_booking_before BEFORE INSERT ON booking
FOR EACH ROW
BEGIN
--validity of returning date in 7 days
   if NEW.date_return > DATE_ADD(NEW.date_hire, INTERVAL 6 DAY)  then
   SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid Return Date';
  end if;
  --validity of booking in 
   if NEW.date_hire > DATE_ADD(NEW.date_booking, INTERVAL 6 DAY)  then
   SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Booking can only be advanced by 7 days only';
  end if;
END//


DELIMITER //
CREATE TRIGGER post_confirmation AFTER UPDATE  ON booking
FOR EACH ROW
BEGIN
   if NEW.state= 'confirmed'  then
   --invoice insertion

   insert into invoice (customer_id,total_amount,date_invoice,vehicle_id)values(NEW.customer_id,NEW.total_amount,NOW(),NEW.vehicle_id);
  update booking set invoice_id=LAST_INSERT_ID() where id=NEW.new_invoice_id;
  	--email enqueue to for cofirmation letter

  	if NEW.date_booking<NEW.date_hire then
  	 insert into email(email,body) values((select email from customer where id =NEW.customer_id),'This is to confirm your Booking');
  	end if;
  	--availability updates of vehicles
  	update availability set is_available=false, date_available = DATE_ADD(NEW.date_return,INTERVAL 1 DAY)
  	where vehicle_id=NEW.vehicle_id;
  end if;

  if NEW.state= 'done'  then
  	update availability set is_available=true, date_available = NOW()
  	where vehicle_id=NEW.vehicle_id;
  end if;
END//
--invoice to be paid check
DELIMITER //
CREATE TRIGGER invoice_paid_check BEFORE UPDATE ON booking
FOR EACH ROW
BEGIN
	DECLARE invoice_state char;
	SELECT  state INTO invoice_state from invoice where id=NEW.invoice_id;
  
   if NEW.state ='in_progress' and invoice_state <> 'paid' then
   SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invoice Must be paid before booking to be in progress';
 
  end if;
END//