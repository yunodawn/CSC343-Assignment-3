SET SEARCH_PATH TO TicketSchema;   

WITH TicketCounts AS(
    SELECT 
        u.username,
        COUNT(t.ticket_id) AS tickets_purchased
        FROM AppUser u
        JOIN Ticket t ON u.user_id = t.user_id
        GROUP BY u.username
)
SELECT username, tickets_purchased
FROM TicketCounts
WHERE tickets_purchased =(
    SELECT MAX(tickets_purchased) FROM TicketCounts);