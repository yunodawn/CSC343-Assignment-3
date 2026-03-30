-- sample data for the TicketSchema database.

SET SEARCH_PATH TO TicketSchema;

-- Owner(owner_id, name, phone)
INSERT INTO Owner VALUES
(1, 'Live Nation Entertainment', '416-555-6969'),
(2, 'LA Music Company', '647-938-1234'),
(3, 'Elon Musk', '902-555-0367');

-- Venue(venue_id, owner_id, name, city, address)
INSERT INTO Venue VALUES
(1, 1, 'Scotiabank Arena', 'Toronto', '40 Bay St'),
(2, 2, 'The Danforth Music Hall', 'Toronto', '147 Danforth Ave'),
(3, 1, 'Rogers Centre', 'Toronto', '1 Blue Jays Way');

-- Section(section_id, venue_id, section_name)
INSERT INTO Section VALUES
(1, 1, 'Floor Level'),
(2, 1, 'Lower Bowl 100s'),
(3, 2, 'General Admission Floor'),
(4, 2, 'VIP Balcony'),
(5, 3, 'Field Level');

-- Seat(seat_id, section_id, seat_name, is_accessible)
INSERT INTO Seat VALUES
(1, 1, 'F1', FALSE),
(2, 1, 'F2', FALSE),
(3, 1, 'W-F1', TRUE),
(4, 2, '101-A', FALSE),
(5, 2, '101-B', FALSE),
(6, 3, 'GA-1', FALSE),
(7, 3, 'GA-2', FALSE),
(8, 4, 'BALC-1', FALSE),
(9, 4, 'BALC-2', FALSE),
(10, 4, 'W-BALC', TRUE),
(11, 5, 'FL-A', FALSE),
(12, 5, 'FL-B', FALSE);

-- Concert(concert_id, venue_id, name, concert_date_time)
INSERT INTO Concert VALUES
(1, 1, 'Taylor Swift - Eras Tour', '2026-10-01 19:30:00'),
(2, 1, 'Taylor Swift - Eras Tour', '2026-10-02 19:30:00'),
(3, 2, 'Arctic Monkeys', '2026-05-17 20:00:00'),
(4, 3, 'The Weeknd - After Hours', '2026-11-20 21:00:00');

-- ConcertSectionPrice(price_id, concert_id, section_id, price)
INSERT INTO ConcertSectionPrice VALUES
(1, 1, 1, 350.00),
(2, 1, 2, 150.00),
(3, 2, 1, 350.00),
(4, 2, 2, 150.00),
(5, 3, 3, 75.00),
(6, 3, 4, 120.00),
(7, 4, 5, 250.00);

-- AppUser(user_id, username)
INSERT INTO AppUser VALUES
(1, 'opiumtester'),
(2, 'insomnizak'),
(3, 'temu_giveaway55'),
(4, 'john_smith');

-- TICKET(ticket_id, user_id, concert_id, seat_id, purchase_date)
INSERT INTO TICKET VALUES
(1, 2, 1, 1, '2026-01-15 10:00:00'),
(2, 2, 1, 2, '2026-01-15 10:00:00'),
(3, 1, 2, 4, '2026-01-15 10:05:00'),
(4, 4, 3, 8, '2026-02-20 12:00:00'),
(5, 4, 3, 9, '2026-02-20 12:00:00'),
(6, 3, 3, 10, '2026-02-21 14:30:00'),
(7, 1, 4, 11, '2026-05-01 09:00:00');