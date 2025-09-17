CREATE DATABASE ai_store;

-- create tables

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    registration_date DATE
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price NUMERIC(10, 2) 
);

CREATE TABLE reviews (
    review_id SERIAL PRIMARY KEY,
    product_id INT REFERENCES products(product_id), -- foreign key link
    user_id INT REFERENCES users(user_id), -- foreign key link
    rating INT CHECK (rating >= 1 AND rating <=5),
    review_text TEXT,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- insert sample data

INSERT INTO users (username, registration_date) VALUES
    ('rajat', '2023-01-15'),
    ('bob', '2023-02-20'),
    ('charlie', '2023-03-10');

INSERT INTO products (product_name, category, price) VALUES 
    ('Laptop', 'Electronics', 999.99),
    ('Smartphone', 'Electronics', 699.99),
    ('Headphones', 'Accessories', 199.99),
    ('SQL for AI Book', 'Books', 49.99);


INSERT INTO reviews (product_id, user_id, rating, review_text) VALUES
    (1, 1, 5, 'Excellent laptop with great performance!'),
    (2, 2, 4, 'Good smartphone but battery life could be better.'),
    (3, 3, 3, 'Average headphones, sound quality is okay.'),
    (4, 1, 5, 'Must-read book for anyone interested in SQL and AI.');


-- foundational retrieval queries - select, from, where

SELECT * FROM users;

-- find all the products that cost more than $50

SELECT product_name, price FROM products WHERE price > 50;

-- find all reviews with a rating of 4 or higher

SELECT * FROM reviews WHERE rating >= 4;

-- order by and limit

-- show me our products from cheapest to most expensive

SELECT * FROM products ORDER BY price ASC;

SELECT product_name FROM products ORDER BY price DESC;

-- who was the very first user to register on our platform?

SELECT * FROM users ORDER BY registration_date ASC LIMIT 1;

-- group by and aggregate functions(count, avg)

-- how many products are in each category?

SELECT category, COUNT(*) AS num_products FROM products GROUP BY category;

SELECT category, COUNT(*) FROM products GROUP BY category;