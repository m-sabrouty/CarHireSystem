DELIMITER $$

CREATE PROCEDURE check_availability(
    date_hire datetime, 
    vehicle_name varchar
)
AS(
    select availability.date_available, vehicle.name from availability ,vehicle 
    where availability.vehicle_id=vehicle.id
    and vehicle.name like '%vehicle_name%' and availability.date_available=date_hire;
  )  
END$$
