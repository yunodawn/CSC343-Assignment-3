-- explnation of database goes here
-- TODO: how tf do i enforce minimum of 10 seats in a venue
-- maggie if u know how to do this pls lmk 

-- COULD NOT:

-- DID NOT: 

-- EXTRA CONSTRAINTS:

-- ASSUMPTIONS:
-- 1. assume that all the seats in the same section of a venue
-- have the same price for that concert 
-- 2. assume that all tickets must have a price > 0
-- 3. we can use TIMESTAMP for the dates and times of the concerts
-- and also the ticket purchases
-- 4. we can use VARCHAR for all names and usernames
-- and the character limit is guessed 
-- 5. 

DROP SCHEMA IF EXISTS TicketSchema CASCADE;
CREATE SCHEMA TicketSchema;
SET SEARCH_PATH TO TicketSchema;

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
)

-- an owner of one or more venues
-- <owner_id> is the invented primary key
-- <name> is the string representing who the owner is 
-- <phone> is the owners phone number (unique)
CREATE TABLE Owner(
    owner_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL UNIQUE
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
    UNIQUE (venue_id, name)
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
    section_id INT NOT NULL REFERENCES Section(concert_id),
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
    ticket_id SERIAL PRIMARY KEY
    user_id INT NOT NULL REFERENCES AppUser(user_id),
    concert_id INT NOT NULL REFERENCES Concert(concert_id),
    seat_id INT NOT NULL REFERENCES Seat(seat_id),
    purchase_date TIMESTAMP NOT NULL,
    UNIQUE (concert_id, seat_id)
);