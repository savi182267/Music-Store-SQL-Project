
--Q1: Who is the senior most employee based on job title?

SELECT Top 1 * FROM employee
ORDER BY levels DESC

--Q2: Which countries have the most Invoices?

SELECT TOP 1 billing_country, COUNT(billing_country) AS TOTAL_COUNT 
FROM invoice
GROUP BY billing_country
ORDER BY TOTAL DESC

--Q3: What are top 3 values of total invoice?

SELECT TOP 3 total FROM invoice
ORDER BY total DESC

--Q4: Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
--Write a query that returns one city that has the highest sum of invoice totals. Return both the city name & sum of all invoice totals

SELECT TOP 1 billing_city, SUM(total) AS [INVOICE TOTAL] FROM invoice
GROUP BY billing_city
ORDER BY [INVOICE TOTAL] DESC


--Q5: Who is the best customer? The customer who has spent the most money will be declared the best customer. 
--Write a query that returns the person who has spent the most money.

SELECT TOP 1 CUSTOMER.customer_id, customer.first_name, customer.last_name, SUM(invoice.total) AS [Total Spent] FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id,customer.first_name, customer.last_name
ORDER BY [Total Spent] DESC

--Q6: Write query to return the email, first name, last name, & Genre of all Rock Music listeners.
--Return your list ordered alphabetically by email starting with A.

SELECT DISTINCT email,first_name, last_name
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
WHERE track_id IN(
	SELECT track_id FROM track
	JOIN genre ON track.genre_id = genre.genre_id
	WHERE genre.name LIKE 'Rock')
ORDER BY email

--Q7: Let's invite the artists who have written the most rock music in our dataset.
--Write a query that returns the Artist name and total track count of the top 10 rock bands.

SELECT TOP 10 artist.artist_id, artist.name,COUNT(artist.artist_id) AS number_of_songs
FROM track
JOIN album2 ON album2.album_id = track.album_id
JOIN artist ON artist.artist_id = album2.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
GROUP BY artist.artist_id,artist.name
ORDER BY number_of_songs DESC

--Q8: Return all the track names that have a song length longer than the average song length.
--Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first.

SELECT name, milliseconds FROM track
WHERE milliseconds > (SELECT AVG(milliseconds) FROM track)
ORDER BY milliseconds DESC
