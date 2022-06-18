CREATE VIEW daily_booking_report AS
    SELECT 
        booking.id,
        customer.name,
        customer.phone,
        vehicle.name as vehicle,
        booking.date_booking,
        booking.date_hire,
        booking.date_return

    FROM
        booking
    Inner Join customer ON customer.id=booking.customer_id
    Inner Join vehicle ON vehicle.id=booking.vehicle_id
    where  CAST(booking.date_booking AS DATE) = CAST(NOW() AS DATE) 
    or CAST(booking.date_hire AS DATE) = CAST(NOW() AS DATE);