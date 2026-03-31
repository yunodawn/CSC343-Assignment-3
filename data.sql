-- sample data for the TicketSchema database
-- NOTE: sample data here was partially generated using Microsoft Copilot (UofT instance) 
-- and then modified by hand to fit the schema and to be more realistic
-- all data here was verified manually 

SET SEARCH_PATH TO TicketSchema;

-- Owner(owner_id, name, phone)
INSERT INTO Owner VALUES
(1, 'Live Nation Entertainment', '416-555-6969'),
(2, 'Indie Events', '647-938-1234'),
(3, 'Elon Musk', '902-555-0367'),
(4, 'Eventbrite', '212-555-7890'),
(5, 'AEG Presents', '310-539-2468');

-- Venue(venue_id, owner_id, name, city, address)
INSERT INTO Venue VALUES
(1, 1, 'Scotiabank Arena', 'Toronto', '40 Bay St'),
(2, 2, 'The Danforth Music Hall', 'Toronto', '147 Danforth Ave'),
(3, 1, 'Rogers Centre', 'Toronto', '1 Blue Jays Way'),
(4, 1, 'Budweiser Stage', 'Toronto', '909 Lake Shore Blvd'),
(5, 1, 'History', 'Toronto', '1663 Queen St E'),
(6, 2, 'Velvet Underground', 'Toronto', '508 Queen St W'),
(7, 2, 'Rebel Nightclub', 'Toronto', '11 Polson St'),
(8, 3, 'Opera House', 'Toronto', '735 Queen St E'),
(9, 4, 'Mod Club', 'Toronto', '722 College St'),
(10, 5, 'Axis Club', 'Toronto', '722 College St');

-- Section(section_id, venue_id, section_name)
INSERT INTO Section VALUES
(1, 1, 'Floor Level'),
(2, 1, 'Lower Bowl 100s'),
(3, 2, 'General Admission Floor'),
(4, 2, 'VIP Balcony'),
(5, 3, 'Field Level')
(6, 3, 'Lower Level'),
(7, 4, 'Lawn Seating'),
(8, 5, 'Main Floor'),
(9, 6, 'General Admission'),
(10, 7, 'Main Floor'),
(11, 8, 'Orchestra'),
(12, 9, 'Main Floor');

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
(12, 5, 'FL-B', FALSE),
(13, 6, 'LL-A', FALSE),
(14, 6, 'LL-B', FALSE),
(15, 7, 'LAWN-1', FALSE),
(16, 7, 'LAWN-2', FALSE),
(17, 8, 'MF-1', FALSE),
(18, 8, 'MF-2', FALSE),
(19, 9, 'GA-1', FALSE),
(20, 9, 'GA-2', FALSE),
(21, 10, 'MF-1', FALSE),
(22, 10, 'MF-2', FALSE),
(23, 11, 'ORCH-A', FALSE),
(24, 11, 'ORCH-B', FALSE),
(25, 12, 'MF-1', FALSE),
(26, 12, 'MF-2', FALSE),
(27, 12, 'W-MF', TRUE),
(28, 1, 'F3', FALSE),
(29, 1, 'F4', FALSE),
(30, 1, 'F5', FALSE),
(31, 1, 'F6', FALSE),
(32, 1, 'F7', FALSE),
(33, 1, 'F8', FALSE),
(34, 1, 'F9', FALSE),
(35, 1, 'F10', FALSE),
(36, 1, 'F11', FALSE),
(37, 1, 'F12', FALSE),
(38, 1, 'F13', FALSE),
(39, 1, 'F14', FALSE),
(40, 1, 'F15', FALSE),
(41, 1, 'F16', FALSE),
(42, 1, 'F17', FALSE),
(43, 1, 'F18', FALSE),
(44, 1, 'F19', FALSE),
(45, 1, 'F20', FALSE),
(46, 1, 'F21', FALSE),
(47, 1, 'F22', FALSE),
(48, 1, 'F23', FALSE),
(49, 1, 'F24', FALSE),
(50, 1, 'F25', FALSE);

-- Concert(concert_id, venue_id, name, concert_date_time)
INSERT INTO Concert VALUES
(1, 1, 'Taylor Swift - Eras Tour', '2026-10-01 19:30:00'),
(2, 1, 'Taylor Swift - Eras Tour', '2026-10-02 19:30:00'),
(3, 2, 'Coldplay - World Tour', '2026-05-17 20:00:00'),
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
(2, 'magnolia_liu'),
(3, 'temu_giveaway55'),
(4, 'john_smith');

-- Ticket(ticket_id, user_id, concert_id, seat_id, purchase_date)
INSERT INTO TICKET VALUES
(1, 2, 3, 1, '2026-01-15 10:00:00'),
(2, 2, 3, 2, '2026-01-15 10:00:00'),
(3, 1, 3, 3, '2026-01-15 10:05:00'),
(4, 4, 3, 4, '2026-02-20 12:00:00'),
(5, 4, 3, 5, '2026-02-20 12:00:00'),
(6, 3, 3, 6, '2026-02-21 14:30:00'),
(7, 1, 3, 7, '2026-05-01 09:00:00'),
(8, 1, 3, 8, '2026-01-15 10:10:00'),
(9, 1, 3, 9, '2026-01-15 10:11:00'),
(10, 1, 3, 10, '2026-01-15 10:12:00'),
(11, 1, 3, 11, '2026-01-15 10:13:00'),
(12, 1, 3, 12, '2026-01-15 10:14:00'),
(13, 1, 3, 13, '2026-01-15 10:15:00'),
(14, 1, 3, 14, '2026-01-15 10:16:00'),
(15, 1, 3, 15, '2026-01-15 10:17:00'),
(16, 1, 3, 16, '2026-01-15 10:18:00'),
(17, 1, 3, 17, '2026-01-15 10:19:00'),
(18, 1, 3, 18, '2026-01-15 10:20:00'),
(19, 1, 3, 19, '2026-01-15 10:21:00'),
(20, 1, 3, 20, '2026-01-15 10:22:00'),
(21, 1, 3, 21, '2026-01-15 10:23:00'),
(22, 1, 3, 22, '2026-01-15 10:24:00'),
(23, 1, 3, 23, '2026-01-15 10:25:00'),
(24, 1, 3, 24, '2026-01-15 10:26:00'),
(25, 1, 3, 25, '2026-01-15 10:27:00'),
(26, 1, 3, 26, '2026-01-15 10:28:00'),
(27, 1, 3, 27, '2026-01-15 10:29:00'),
(28, 1, 3, 28, '2026-01-15 10:30:00'),
(29, 1, 3, 29, '2026-01-15 10:31:00'),
(30, 1, 3, 30, '2026-02-01 11:00:00'),
(31, 1, 3, 31, '2026-02-01 11:01:00'),
(32, 1, 3, 32, '2026-02-01 11:02:00'),
(33, 1, 3, 33, '2026-02-01 11:03:00'),
(34, 1, 3, 34, '2026-02-01 11:04:00'),
(35, 1, 3, 35, '2026-02-01 11:05:00'),
(36, 1, 3, 36, '2026-02-01 11:06:00'),
(37, 1, 3, 37, '2026-02-01 11:07:00'),
(38, 1, 3, 38, '2026-02-01 11:08:00'),
(39, 1, 3, 39, '2026-02-01 11:09:00'),
(40, 1, 3, 40, '2026-05-01 09:30:00'),
(41, 1, 3, 41, '2026-05-01 09:31:00'),
(42, 1, 3, 42, '2026-05-01 09:32:00'),
(43, 1, 3, 43, '2026-05-01 09:33:00'),
(44, 1, 3, 44, '2026-05-01 09:34:00'),
(45, 1, 3, 45, '2026-05-01 09:35:00'),
(46, 1, 3, 46, '2026-05-01 09:36:00'),
(47, 1, 3, 47, '2026-05-01 09:37:00'),
(48, 1, 3, 48, '2026-05-01 09:38:00'),
(49, 1, 3, 49, '2026-05-01 09:39:00'),
(50, 1, 3, 50, '2026-05-01 09:40:00'),
(51, 1, 3, 51, '2026-05-01 09:41:00');