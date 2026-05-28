-- Active: 1777818926466@@127.0.0.1@5432@MUSIC_DATABASE@public

-- Q1 : Who is the senior most employee based on job title

SELECT * FROM employee

SELECT *
FROM employee
WHERE LEVELS = (
    SELECT MAX(LEVELS)
    FROM employee
)


-- Q2 : WHICH COUNTRY HAS MOST INVOICES 

SELECT COUNT(*) AS C, billing_country 
FROM invoice
GROUP BY billing_country
ORDER BY C DESC


-- Q3 : WHAT ARE TOP 3 VALUES OF TOTAL INVOICES

SELECT * FROM INVOICE

SELECT  TOTAL FROM INVOICE
ORDER BY TOTAL DESC
LIMIT 3


-- Q4 : Which city has the best customers? We would like to throw a promotional Music Festival in the city 2 we made the most money. Write a query, that returns one city that has the highest sum of invoice totals.RETURN BOTH THE CITY NAME AND SUM OF TOTAL INVOICE

SELECT SUM(TOTAL) AS INVOICE_TOTAL, billing_city
FROM invoice
GROUP BY billing_city
ORDER BY INVOICE_TOTAL DESC


-- Q5 : Who is the best customer? The customer who has spent the most money will be declared the best customer. Write a query that returns the person who has spent the most money.

SELECT CUSTOMER.customer_id, customer.FIRST_NAME, CUSTOMER.last_name, SUM(INVOICE.TOTAL) AS TOTAL
FROM customer
JOIN INVOICE ON CUSTOMER.customer_id = INVOICE.customer_id
GROUP BY CUSTOMER.customer_id
ORDER BY TOTAL DESC
LIMIT 1


-- Q6 - Write query to return the email, first name, last name, & Genre of all Rock Music listeners. Return your list ordered alphabetically by email starting with A


SELECT DISTINCT EMAIL, FIRST_NAME, last_name
FROM customer
JOIN INVOICE ON CUSTOMER.customer_id = INVOICE.customer_id
JOIN invoice_line ON INVOICE.INVOICE_ID = INVOICE_LINE.invoice_id
WHERE TRACK_ID IN(
    SELECT TRACK_ID FROM track
    JOIN GENRE ON TRACK.GENRE_ID = GENRE.genre_id
    WHERE GENRE.NAME LIKE 'ROCK'
) 
ORDER BY EMAIL;


-- Q7 - Let's invite the artists who have written the most rock music in our dataset. Write a query that returns the Artist name and total track count of the top 10 rock bands

SELECT ARTIST.ARTIST_ID, ARTIST.NAME,COUNT(ARTIST.ARTIST_ID) AS NUMBER_OF_SONGS
FROM track
JOIN ALBUM ON ALBUM.ALBUM_ID = TRACK.album_id
JOIN ARTIST ON ARTIST.artist_id = ALBUM.artist_id
JOIN genre ON genre.genre_id = TRACK.genre_id
WHERE genre.name LIKE 'ROCK'
GROUP BY ARTIST.artist_id
ORDER BY NUMBER_OF_SONGS DESC
LIMIT 10;


-- Q8 -- Return all the track names that have a song length longer than the average song length. Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first.

SELECT NAME,MILLISECONDS
FROM track
WHERE MILLISECONDS > (
    SELECT AVG(milliseconds) AS AVG_TRACK_LENGTH
    FROM TRACK
)
ORDER BY MILLISECONDS DESC;


