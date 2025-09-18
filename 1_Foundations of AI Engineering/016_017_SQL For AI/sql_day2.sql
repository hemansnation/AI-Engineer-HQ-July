-- list all the products in the product table

SELECT * FROM products;

-- join

-- show all the reviews and include username of the person who wrote the review

SELECT r.rating, r.review_text, u.username  FROM reviews AS r
JOIN users AS u ON r.user_id = u.user_id;

-- lets create training dataset - product name, its category, rating and the username of the reviewer

SELECT p.product_name, p.category, r.rating, u.username
FROM reviews AS r
JOIN products AS p ON r.product_id = p.product_id
JOIN users AS u ON r.user_id = u.user_id;


SELECT p.product_name, p.category, r.rating, u.username
FROM reviews AS r
JOIN products AS p ON r.product_id = p.product_id
JOIN users AS u ON r.user_id = u.user_id
WHERE p.category = 'Electronics';


