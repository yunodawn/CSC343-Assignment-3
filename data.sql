-- sample data for the TicketSchema database
-- NOTE: sample data was partially generated using Microsoft Copilot (UofT instance) 
-- and then modified by hand to fit the schema and to be more realistic
-- all data here was verified manually, some places/people are real and some are fake

SET SEARCH_PATH TO TicketSchema;

-- Owner(owner_id, name, phone)
-- need at least 5 owners for 5 rows in q2
INSERT INTO Owner VALUES
(1, 'Live Nation Entertainment', '416-555-6969'),
(2, 'Indie Events', '647-938-1234'),
(3, 'Elon Musk', '902-555-0367'),
(4, 'Eventbrite', '212-555-7890'),
(5, 'AEG Presents', '310-539-2468');

-- Venue(venue_id, owner_id, name, city, address)
-- need at least 10 venues for 10 rows in q3
--AND one owner has 3+ venues for q2
INSERT INTO Venue VALUES
(1, 1, 'Scotiabank Arena', 'Toronto', '40 Bay St'),
(2, 1, 'The Danforth Music Hall', 'Toronto', '147 Danforth Ave'),
(3, 1, 'Rogers Centre', 'Toronto', '1 Blue Jays Way'),
(4, 1, 'Budweiser Stage', 'Toronto', '909 Lake Shore Blvd'),
(5, 2, 'History', 'Toronto', '1663 Queen St E'),
(6, 2, 'Velvet Underground', 'Toronto', '508 Queen St W'),
(7, 3, 'Rebel Nightclub', 'Toronto', '11 Polson St'),
(8, 3, 'Opera House', 'Toronto', '735 Queen St E'),
(9, 4, 'Mod Club', 'Toronto', '722 College St'),
(10, 5, 'Axis Club', 'Toronto', '722 College St');

-- Section(section_id, venue_id, section_name)
-- need at least 1 section for each venue 
INSERT INTO Section VALUES
(1, 1, 'Main Floor'), 
(2, 2, 'Main Floor'), 
(3, 3, 'Main Floor'), 
(4, 4, 'Main Floor'), 
(5, 5, 'Main Floor'), 
(6, 6, 'Main Floor'), 
(7, 7, 'Main Floor'), 
(8, 8, 'Main Floor'), 
(9, 9, 'Main Floor'), 
(10, 10, 'Main Floor');

-- Seat(seat_id, section_id, seat_name, is_accessible)
-- every venye has at least 10 seats 
-- im not writing allat out 
DO $$
DECLARE
    s_id INT;
    i INT;
BEGIN
    -- need at least 1 venue w 50 seats so use venue 1 (section 1) 
    FOR i IN 1..50 LOOP
        INSERT INTO Seat (section_id, seat_name, is_accessible) 
        VALUES (1, 'F' || i, FALSE);
    END LOOP;

    -- need at least 10 seats in venue 2-10
    FOR s_id IN 2..10 LOOP
        FOR i IN 1..10 LOOP
            -- need at least 1 venue to have 3/10 accessible seats so use venue 2
            IF s_id = 2 AND i <= 3 THEN
                INSERT INTO Seat (section_id, seat_name, is_accessible) 
                VALUES (s_id, 'S' || i, TRUE);
            ELSE
                INSERT INTO Seat (section_id, seat_name, is_accessible) 
                VALUES (s_id, 'S' || i, FALSE);
            END IF;
        END LOOP;
    END LOOP;
END $$;

-- Concert(concert_id, venue_id, name, concert_date_time)
INSERT INTO Concert VALUES
(1, 1, 'Taylor Swift - Eras Tour', '2026-10-01 19:30:00'),
(2, 2, 'Coldplay - World Tour', '2026-05-17 20:00:00'),
(3, 3, 'The Weeknd - After Hours', '2026-11-20 21:00:00');

-- ConcertSectionPrice(price_id, concert_id, section_id, price)
INSERT INTO ConcertSectionPrice VALUES
(1, 1, 1, 350.00),
(2, 2, 2, 150.00),
(3, 3, 3, 350.00);

-- AppUser(user_id, username)
INSERT INTO AppUser VALUES
(1, 'playboi_farti'),
(2, 'asu_frat_leader'),
(3, 'temu_giveaway55'),
(4, 'nicki_minaj_flopped');

-- Ticket(ticket_id, user_id, concert_id, seat_id, purchase_date)
-- one concert has 50 tickets sold
-- one concert has between 0 and 50 tickets sold
-- and one concert has 0 ticket sold 
-- max ticket buyer needs to buy 25 tickets  
DO $$
DECLARE
    i INT;
BEGIN
    -- user 1 buys 50 tickets for concert 1 
    -- buys all the seats in venue 1 which is the only one w/ 50 seats
    -- buy all the tickets at the same time but idk if thats realistic- maggie confirm?
    FOR i IN 1..50 LOOP
        INSERT INTO Ticket (user_id, concert_id, seat_id, purchase_date) 
        VALUES (1, 1, i, '2026-01-15 10:00:00');
    END LOOP;

    -- user 2 buys 2 tickets for concert 2
    -- these are seat_ids 51 and 52, in ienue 2 where concert 2 should be held
    FOR i IN 51..52 LOOP
        INSERT INTO Ticket (user_id, concert_id, seat_id, purchase_date) 
        VALUES (2, 2, i, '2026-05-01 09:41:00');
    END LOOP;
    
    -- concert 3 needs 0 tickets sold 
END $$;