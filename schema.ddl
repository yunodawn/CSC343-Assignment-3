-- explanation of database goes here
-- TODO: enforce min 10 seats in the venue

-- COULD NOT:
-- 1. I don't think it's possible to enforce a minimum of 
-- 10 seats in a venue we would need to use 
-- an aggregate function like COUNT() to look at 
-- multiple rows in the Seat table, and then trace 
-- it back to Section and group it by Venue
-- and we can't use aggregate functions on other tables in SQL DDL

-- this would also create a problem where if we try 
-- to make a new venue then it wouldnt have 10 seats
-- yet so it would not be allowed, but you cant make 
-- 10 seats for a venue that doesnt exist yet either 

-- 2. i also cant enforce that a Ticket's seat_id physically 
-- exists inside the venue_id where the concert_id is taking place
-- this is because we used single integer primary keys 
-- so technically someone could buy a ticket for a concert 
-- for a seat thats in another venue (not the one holding the concert)

-- DID NOT: 
-- 1. I didn't make an extra table for Ticket Purchases
-- If someone wants to buy multiple tickets in the same purchase
-- the time of purchase will simply be the same for those tickets
-- in the Ticket table, and the id of the user who purchased them 
-- will also be the same, this satisfies the constraint  

-- 2. I didn't store the owners name and number in 
-- the Venue table cause it seemed redundant to repeat the 
-- information multiple times for owners that own many venues 
-- instead i made owners its own table 

-- EXTRA CONSTRAINTS:
-- 1. all ticket prices have to be > $0
-- 2. a seat can only be sold once per concert show 
-- hence the UNIQUE(concert_id, seat_id) 
-- 3. added a UNIQUE(venue_id, section_name) constraint 
-- in the Section table to ensure no venue has two sections with the same name
-- 4. added a UNIQUE(section_id, seat_name) in the Seat table to ensure
-- no two seats in the same section have the same name 
-- 5. enforced NOT NULL on everythin to avoid null logic complication

-- ASSUMPTIONS:
-- 1. assume that all the seats in the same section of a venue
-- have the same price for that concert 
-- 2. assume that all tickets must have a price > 0
-- 3. we can use TIMESTAMP for the dates and times of the concerts
-- and also the ticket purchases
-- 4. we can use VARCHAR for all names and usernames
-- and the character limit is roughly guessed based on
-- standard character limits for names and phone numbers
-- 5. for ticket prices use a max of 2 decimal places to copy real money 

-- KEEP THIS ORDER OF TABLES SO POSTGRE DOESNT BREAK: 
-- owner, venue, section, seat, concert, csp, app, ticket 

DROP SCHEMA IF EXISTS TicketSchema CASCADE;
CREATE SCHEMA TicketSchema;
SET SEARCH_PATH TO TicketSchema;

-- an owner of one or more venues
-- <owner_id> is the invented primary key
-- <name> is the string representing who the owner is 
-- <phone> is the owners phone number (unique)
CREATE TABLE Owner(
    owner_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL UNIQUE
);

-- a venue where concerts are held
-- <venue_id> is the invented primary key 
-- <owner_id> is the single owner of the venue 
-- <name> is the name of the venue (not unique)
-- <city> is the city that the venue is in (not unique)
-- <address> is the street address of the venue (not unique)
CREATE TABLE Venue(
    venue_id SERIAL PRIMARY KEY,
    owner_id INT NOT NULL REFERENCES Owner(owner_id),
    name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    address VARCHAR(200) NOT NULL
);

-- a section in a venue 
-- <section_id> is the invented primary key
-- <venue_id> is the id of the venue that the seciton is in
-- <name> is the name of the section
-- add a UNIQUE constraint to make sure that 
-- only one section_name per the same venue 
CREATE TABLE SECTION(
    section_id SERIAL PRIMARY KEY,
    venue_id INT NOT NULL REFERENCES Venue(venue_id),
    section_name VARCHAR(50) NOT NULL,
    UNIQUE (venue_id, section_name)
);

-- a seat in a section
-- <seat_id> is the invented primary key
-- section_id is the section of the seat
-- <seat_name> is the string name of the seat
-- <is_accessible> is the boolean that states whether the seat is for
-- people with accessibility needs 
-- add a UNIQUE constraint to make sure that 
-- seat names dont repeat in the same section
CREATE TABLE Seat(
    seat_id SERIAL PRIMARY KEY,
    section_id INT NOT NULL REFERENCES Section(section_id),
    seat_name VARCHAR(20) NOT NULL,
    is_accessible BOOLEAN NOT NULL,
    UNIQUE (section_id, seat_name)
); 

-- a concert 
-- <concert_id> is the invented primary key
-- <venue_id> is the id of the venue hosting the concert
-- <name> is the concert name
-- add a UNIQUE constraint to make sure that
-- two concerts cant have the same venue, date, and time
CREATE TABLE Concert(
    concert_id SERIAL PRIMARY KEY,
    venue_id INT NOT NULL REFERENCES Venue(venue_id),
    name VARCHAR(150) NOT NULL,
    concert_date_time TIMESTAMP NOT NULL,
    UNIQUE (venue_id, concert_date_time)
);

-- prices of tickets in a concert
-- price depends on the concert and also the section in the venue 
-- <price_id> is the invented primary key
-- <concert_id> is the id of the concert
-- <section_id> is the id of the section in the venue for that concert
-- price is the price of that ticket
-- add a UNIQUE constraing to make sure that
-- price is consistent across one section 
CREATE TABLE ConcertSectionPrice(
    price_id SERIAL PRIMARY KEY,
    concert_id INT NOT NULL REFERENCES Concert(concert_id),
    section_id INT NOT NULL REFERENCES Section(section_id),
    price NUMERIC (10, 2) NOT NULL CHECK (price > 0),
    UNIQUE (concert_id, section_id)
);

-- a user in the app 
-- <user_id> is the invented primary key
-- <username> is the username of the user (unique)
CREATE TABLE AppUser(
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE
);

-- a ticket that was purchased
-- <ticket_id> is the invented primary key 
-- <user_id> is the id of the app user who purchased it
-- <concert_id> is the concert the ticket was purchased for 
-- <seat_id> is the seat corresponding to the ticket
-- <purchase_date> is the date and time when the ticket purchase happened
-- add a UNIQUE constraint to make sure that 
-- no two users can buy the same seat for the same concert 
CREATE TABLE TICKET(
    ticket_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES AppUser(user_id),
    concert_id INT NOT NULL REFERENCES Concert(concert_id),
    seat_id INT NOT NULL REFERENCES Seat(seat_id),
    purchase_date TIMESTAMP NOT NULL,
    UNIQUE (concert_id, seat_id)
);