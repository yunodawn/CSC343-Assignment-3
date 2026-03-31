SET SEARCH_PATH TO TicketSchema;   

For each venue, report the number of seats and the percentage of seats that are accessible. There must be at
least 10 rows in the result, and each venue must have at least 10 seats. At least one venue must be at least
25% accessible.

SELECT 
    v.name AS venue_name,
    COUNT(s.seat_id) AS total_seats,
    COUNT(CASE WHEN s.is_accessible = TRUE THEN 1 END)::DECIMAL
    / COUNT(s.seat_id) * 100, 2 AS accessible_seats_percentage
FROM Venue v,
JOIN Section sec ON v.venue_id = sec.venue_id
JOIN Seat s ON sec.section_id = s.section_id
GROUP BY v.venue_id, v.name
ORDER BY accessible_seats_percentage DESC;