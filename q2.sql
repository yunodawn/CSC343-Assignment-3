SET SEARCH_PATH TO TicketSchema;    

SELECT 
    o.owner_id,
    o.name AS owner_name,
    COUNT(v.venue_id) AS num_venues_owned
FROM Owner o
LEFT JOIN Venue v ON o.owner_id = v.owner_id
GROUP BY o.owner_id, o.name
ORDER BY num_venues_owned DESC;