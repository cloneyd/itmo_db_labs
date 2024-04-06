SET SCHEMA 'marketplace';

CREATE VIEW vw_OrderProductsByUser AS
SELECT
    o.order_id,
    u.name AS user_name,
    p.name AS product_name,
    oi.quantity,
    oi.price
FROM orders o
INNER JOIN users u ON o.user_id = u.user_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN products p ON oi.product_id = p.product_id;

CREATE VIEW vw_PopularProducts AS
SELECT
    p.product_id,
    p.name AS product_name,
    COUNT(oi.product_id) AS total_orders,
    SUM(oi.quantity) AS total_quantity
FROM orders o
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.name
ORDER BY total_orders DESC;
