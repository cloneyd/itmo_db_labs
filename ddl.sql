DROP SCHEMA IF EXISTS marketplace CASCADE;

CREATE SCHEMA marketplace;
SET SCHEMA 'marketplace';

CREATE TYPE user_role AS ENUM('buyer', 'seller', 'admin');
CREATE TYPE order_status AS ENUM('new', 'processing', 'shipped', 'completed', 'canceled');

CREATE TABLE users
(
    user_id  SERIAL PRIMARY KEY,
    name     VARCHAR(255) NOT NULL,
    email    VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role     user_role    NOT NULL
);

CREATE TABLE categories
(
    category_id        SERIAL PRIMARY KEY,
    name               VARCHAR(255) NOT NULL,
    parent_category_id INT DEFAULT NULL,
    CONSTRAINT fk_categories_parent
        FOREIGN KEY (parent_category_id)
            REFERENCES categories (category_id)
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

CREATE TABLE manufacturers
(
    manufacturer_id SERIAL PRIMARY KEY,
    name            VARCHAR(255) NOT NULL
);

CREATE TABLE products
(
    product_id      SERIAL PRIMARY KEY,
    name            VARCHAR(255)   NOT NULL,
    description     TEXT,
    price           DECIMAL(10, 2) NOT NULL,
    category_id     INT,
    manufacturer_id INT,
    quantity        INT            NOT NULL,
    image_url       VARCHAR(255),
    CONSTRAINT fk_products_category
        FOREIGN KEY (category_id)
            REFERENCES categories (category_id)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT fk_products_manufacturer
        FOREIGN KEY (manufacturer_id)
            REFERENCES manufacturers (manufacturer_id)
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

CREATE TABLE products_categories
(
    product_id  INT NOT NULL,
    category_id INT NOT NULL,
    PRIMARY KEY (product_id, category_id),
    CONSTRAINT fk_products_categories_product
        FOREIGN KEY (product_id)
            REFERENCES products (product_id)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT fk_products_categories_category
        FOREIGN KEY (category_id)
            REFERENCES categories (category_id)
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

CREATE TABLE payment_methods
(
    payment_method_id SERIAL PRIMARY KEY,
    name              VARCHAR(255) NOT NULL
);


CREATE TABLE shipping_methods
(
    shipping_method_id SERIAL PRIMARY KEY,
    name               VARCHAR(255)   NOT NULL,
    cost               DECIMAL(10, 2) NOT NULL
);

CREATE TABLE orders
(
    order_id           SERIAL PRIMARY KEY,
    order_date         TIMESTAMP      NOT NULL,
    status             order_status   NOT NULL,
    user_id            INT            NOT NULL,
    payment_method_id  INT,
    shipping_method_id INT,
    total_cost         DECIMAL(10, 2) NOT NULL,
    shipping_address   VARCHAR(255),
    CONSTRAINT fk_orders_user
        FOREIGN KEY (user_id)
            REFERENCES users (user_id)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT fk_orders_payment_method
        FOREIGN KEY (payment_method_id)
            REFERENCES payment_methods (payment_method_id)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT fk_orders_shipping_method
        FOREIGN KEY (shipping_method_id)
            REFERENCES shipping_methods (shipping_method_id)
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

CREATE TABLE order_items
(
    order_item_id SERIAL PRIMARY KEY,
    order_id      INT            NOT NULL,
    product_id    INT            NOT NULL,
    quantity      INT            NOT NULL,
    price         DECIMAL(10, 2) NOT NULL,
    CONSTRAINT fk_order_items_order
        FOREIGN KEY (order_id)
            REFERENCES orders (order_id)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT fk_order_items_product
        FOREIGN KEY (product_id)
            REFERENCES products (product_id)
            ON DELETE CASCADE
            ON UPDATE CASCADE
);
