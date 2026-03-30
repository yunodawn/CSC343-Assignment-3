-- explnation of database goes here
-- TODO: how tf do i enforce minimum of 10 seats in a venue
-- maggie if u know how to do this pls lmk 

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

-- prices of tickets in a concert??

-- the users of the app 