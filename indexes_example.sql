SET SCHEMA 'marketplace';

set enable_seqscan=false;

EXPLAIN ANALYZE SELECT * FROM products
WHERE category_id = 1 AND price BETWEEN 100 AND 200
ORDER BY price ASC;

set enable_seqscan=true;

EXPLAIN ANALYZE SELECT * FROM products
WHERE category_id = 1 AND price BETWEEN 100 AND 200
ORDER BY price ASC;

set enable_seqscan=false;

EXPLAIN ANALYZE SELECT * FROM orders
WHERE user_id = 1 AND order_date BETWEEN '2024-01-01' AND '2024-03-31'
ORDER BY order_date DESC;

set enable_seqscan=true;

EXPLAIN ANALYZE SELECT * FROM orders
WHERE user_id = 1 AND order_date BETWEEN '2024-01-01' AND '2024-03-31'
ORDER BY order_date DESC;
