-- explnation of database goes here

DROP SCHEMA IF EXISTS TicketSchema CASCADE;
CREATE SCHEMA TicketSchema;
SET SEARCH_PATH TO TicketSchema;

-- an owner of one or more venues
-- <owner_id> is the invented primary key
-- <name> is the string representing who the owner is 
-- <phone> is the owners phone number 
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
)