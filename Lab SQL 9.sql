-- 1. Write a query to display for each store its store ID, city, and country.
SELECT DISTINCT Store.STORE_ID, City.CITY, Country.COUNTRY
FROM SAKILA.STORE as Store
LEFT JOIN SAKILA.ADDRESS Address
ON Store.ADDRESS_ID = Address.ADDRESS_ID
LEFT JOIN SAKILA.CITY City
ON Address.CITY_ID = City.CITY_ID
LEFT JOIN SAKILA.COUNTRY Country
ON City.COUNTRY_ID = Country.COUNTRY_ID;

-- 2. Write a query to display how much business, in dollars, each store brought in.
SELECT Store.STORE_ID, SUM(Payment.AMOUNT) AS TOTAL
FROM SAKILA.STORE Store
LEFT JOIN SAKILA.STAFF Street 
ON Store.STORE_ID = Street.STORE_ID
LEFT JOIN SAKILA.PAYMENT Payment 
ON Street.STAFF_ID = Payment.STAFF_ID
GROUP BY Store.STORE_ID;

-- 3.What is the average running time of films by category?
SELECT Category.NAME, AVG(Film.LENGTH)
FROM SAKILA.CATEGORY Category
LEFT JOIN SAKILA.FILM_CATEGORY Film_cat
ON Category.CATEGORY_ID = Film_cat.CATEGORY_ID
LEFT JOIN SAKILA.FILM Film
ON Film_cat.FILM_ID = Film.FILM_ID
GROUP BY Category.NAME;

-- 4. Which film categories are longest?
SELECT Category.NAME, SUM(Film.LENGTH) AS LONGEST_CAT
FROM SAKILA.CATEGORY Category
LEFT JOIN SAKILA.FILM_CATEGORY Film_cat
ON Category.CATEGORY_ID = Film_cat.CATEGORY_ID
LEFT JOIN SAKILA.FILM Film
ON Film_cat.FILM_ID = Film.FILM_ID
GROUP BY Category.NAME
ORDER BY LONGEST_CAT DESC;

-- 5. Display the most frequently rented movies in descending order.
SELECT Film.TITLE, COUNT(Rental.RENTAL_ID) AS MOST_RENTED
FROM SAKILA.FILM Film
LEFT JOIN SAKILA.INVENTORY Iventory
ON Film.FILM_ID = Iventory.FILM_ID
LEFT JOIN SAKILA.RENTAL Rental
ON Iventory.INVENTORY_ID = Rental.INVENTORY_ID
GROUP BY Film.TITLE
ORDER BY MOST_RENTED DESC;

-- 6. List the top five genres in gross revenue in descending order.
SELECT Category.NAME, SUM(Payment.AMOUNT) AS TOP_5_REVENUE
FROM SAKILA.CATEGORY Category
LEFT JOIN SAKILA.FILM_CATEGORY Film_cat
ON Category.CATEGORY_ID = Film_cat.CATEGORY_ID
LEFT JOIN SAKILA.FILM Film
ON Film_cat.FILM_ID = Film.FILM_ID
LEFT JOIN SAKILA.INVENTORY Iventory
ON Film.FILM_ID = Iventory.FILM_ID
LEFT JOIN SAKILA.RENTAL Rental
ON Iventory.INVENTORY_ID = Rental.INVENTORY_ID
LEFT JOIN SAKILA.PAYMENT Payment
ON Rental.RENTAL_ID = Payment.RENTAL_ID
GROUP BY Category.NAME
ORDER BY TOP_5_REVENUE DESC
LIMIT 5;

-- 7. Is "Academy Dinosaur" available for rent from Store 1?
SELECT Film.TITLE, Store.STORE_ID
FROM SAKILA.FILM Film
LEFT JOIN SAKILA.INVENTORY Inventory
ON Film.FILM_ID = Inventory.FILM_ID
LEFT JOIN SAKILA.STORE Store
ON Inventory.STORE_ID = Store.STORE_ID
WHERE Film.TITLE = 'Academy Dinosaur' AND Store.STORE_ID = 1;