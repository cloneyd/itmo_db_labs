SET SCHEMA 'marketplace';

CREATE INDEX idx_products_category_price ON products (category_id, price);
CREATE INDEX idx_orders_user_date ON orders (user_id, order_date);
