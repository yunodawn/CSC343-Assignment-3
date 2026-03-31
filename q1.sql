SET SEARCH_PATH TO  TicketSchema;

SELECT 
    c.concert_id,
    c.name AS concert_name,
    COUNT(t.ticket_id) AS total_tickets_sold,
    COALESCE(SUM(csp.price), 0.00) AS total_value_sold,
    ROUND(
        (COUNT(t.ticket_id)::DECIMAL / 
        (SELECT COUNT(*) FROM Seat s 
        JOIN Section sec ON s.section_id = sec.section_id 
        WHERE sec.venue_id = c.venue_id)) * 100, 2
    ) AS percentage_venue_sold

FROM Concert c
LEFT JOIN Ticket t ON c.concert_id = t.concert_id
LEFT JOIN Seat s ON t.seat_id = s.seat_id
LEFT JOIN ConcertSectionPrice csp ON c.concert_id = csp.concert_id
AND s.section_id = csp.section_id
GROUP BY c.concert_id, c.name, c.venue_id
ORDER BY total_tickets_sold DESC;