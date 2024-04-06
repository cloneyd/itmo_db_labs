SET SCHEMA 'orders';

DELETE FROM users RETURNING *;
DELETE FROM categories RETURNING *;
DELETE FROM manufacturers RETURNING *;
DELETE FROM products RETURNING *;
DELETE FROM products_categories RETURNING *;
DELETE FROM payment_methods RETURNING *;
DELETE FROM shipping_methods RETURNING *;
DELETE FROM orders RETURNING *;
DELETE FROM order_items RETURNING *;

INSERT INTO users (name, email, password, role)
VALUES ('Иван', 'ivan@example.com', '123456', 'buyer'),
       ('Мария', 'maria@example.com', '123456', 'buyer'),
       ('Сергей', 'sergey@example.com', '123456', 'seller'),
       ('Анна', 'anna@example.com', '123456', 'seller'),
       ('Андрей', 'andrey@example.com', '123456', 'admin'),
       ('Ольга', 'olga@example.com', '123456', 'buyer'),
       ('Максим', 'maxim@example.com', '123456', 'seller'),
       ('Ирина', 'irina@example.com', '123456', 'seller'),
       ('Михаил', 'mikhail@example.com', '123456', 'buyer'),
       ('Екатерина', 'ekaterina@example.com', '123456', 'buyer'),
       ('Петр', 'petr@example.com', '123456', 'seller'),
       ('Елена', 'elena@example.com', '123456', 'seller'),
       ('Александр', 'alexander@example.com', '123456', 'buyer'),
       ('Дарья', 'darya@example.com', '123456', 'buyer'),
       ('Николай', 'nikolay@example.com', '123456', 'seller');

INSERT INTO categories (name)
VALUES ('Электроника'),
       ('Одежда'),
       ('Товары для дома'),
       ('Спорт и отдых'),
       ('Бытовая техника'),
       ('Компьютеры и ноутбуки'),
       ('Фототехника'),
       ('Товары для хобби и развлечений'),
       ('Книги'),
       ('Детские товары');

INSERT INTO manufacturers (name)
VALUES ('Samsung'),
       ('Apple'),
       ('Nike'),
       ('Adidas'),
       ('Sony'),
       ('LG'),
       ('Bosch'),
       ('Siemens'),
       ('Canon'),
       ('Nikon'),
       ('DJI'),
       ('Xiaomi'),
       ('Realme'),
       ('HP'),
       ('Dell');

INSERT INTO products (name, description, price, category_id, manufacturer_id, quantity, image_url)
VALUES ('Samsung Galaxy S23', 'Новый флагманский смартфон от Samsung', 79900, 1, 1, 10,
        'https://example.com/image1.jpg'),
       ('Apple iPhone 14 Pro Max', 'Самый продвинутый iPhone от Apple', 129900, 1, 2, 5,
        'https://example.com/image2.jpg'),
       ('Nike Air Force 1', 'Легендарные кроссовки Nike', 10000, 4, 3, 20, 'https://example.com/image3.jpg'),
       ('LG OLED TV C2', '4K OLED-телевизор с безупречным изображением', 159900, 2, 4, 5,
        'https://example.com/image4.jpg'),
       ('Sony WH-1000XM5', 'Премиальные беспроводные наушники', 39900, 3, 5, 15, 'https://example.com/image5.jpg'),
       ('Bosch Serie 4 SMV46MX00R', 'Посудомоечная машина', 45900, 6, 6, 7, 'https://example.com/image6.jpg'),
       ('Samsung WW90T554DAW', 'Стиральная машина', 79900, 6, 1, 8, 'https://example.com/image7.jpg'),
       ('LG GSLV70PZXV', 'Холодильник Side-by-Side', 129900, 6, 4, 3, 'https://example.com/image8.jpg'),
       ('Apple MacBook Air M2', 'Ноутбук с новым чипом M2', 109900, 7, 2, 10, 'https://example.com/image9.jpg'),
       ('Lenovo ThinkPad X1 Carbon Gen 10', 'Бизнес-ноутбук премиум-класса', 149900, 7, 7, 5,
        'https://example.com/image10.jpg'),
       ('Canon EOS R6', 'Профессиональная фотокамера', 249900, 8, 8, 3, 'https://example.com/image11.jpg'),
       ('Sony Alpha 7 IV', 'Беззеркальная фотокамера', 219900, 8, 5, 4, 'https://example.com/image12.jpg'),
       ('DJI Mavic 3', 'Дрон с 5.1K-видеокамерой', 159900, 9, 9, 2, 'https://example.com/image13.jpg'),
       ('Xiaomi Mi 12 Pro', 'Флагманский смартфон с топовой камерой', 89900, 1, 10, 7,
        'https://example.com/image14.jpg'),
       ('Realme GT Neo 3', 'Смартфон с быстрой зарядкой 150W', 49900, 1, 11, 10, 'https://example.com/image15.jpg');

COPY products_categories FROM '/var/run/postgres/data/products_categories.csv' csv header;

INSERT INTO payment_methods (name)
VALUES ('Наличными'),
       ('Банковской картой'),
       ('WB кошельком'),
       ('СБП'),
       ('PayPal'),
       ('Яндекс.Деньги'),
       ('Тинькофф.Касса'),
       ('WebMoney'),
       ('Qiwi'),
       ('ЮКassa');

INSERT INTO shipping_methods (name, cost)
VALUES ('Самовывоз', 0),
       ('Доставка курьером', 300),
       ('Почта России', 500),
       ('СДЭК', 400),
       ('BoxBerry', 100);

INSERT INTO orders (order_date, status, user_id, payment_method_id, shipping_method_id, total_cost, shipping_address)
VALUES ('2023-11-16 10:23:54', 'new', 1, 1, 1, 109900, 'ул. Ленина, 12'),
       ('2023-11-17 14:56:12', 'processing', 2, 2, 2, 124900, 'ул. Мира, 25'),
       ('2023-11-18 18:34:01', 'shipped', 3, 3, 3, 11000, 'ул. Садовая, 37'),
       ('2023-11-19 12:00:00', 'completed', 4, 1, 2, 139900, 'ул. Пушкина, 5'),
       ('2023-11-20 16:34:56', 'canceled', 5, 2, 3, 10500, 'ул. Тургенева, 10'),
       ('2023-11-21 10:00:00', 'new', 6, 3, 1, 120000, 'ул. Чехова, 15'),
       ('2023-11-22 14:30:00', 'processing', 7, 2, 2, 115000, 'ул. Горького, 20'),
       ('2023-11-23 18:00:00', 'shipped', 8, 3, 3, 10000, 'ул. Маяковского, 25'),
       ('2023-11-24 12:00:00', 'completed', 9, 1, 2, 125000, 'ул. Достоевского, 30'),
       ('2023-11-25 16:30:00', 'canceled', 10, 2, 3, 110000, 'ул. Толстого, 35'),
       ('2023-11-26 10:00:00', 'new', 11, 3, 1, 130000, 'ул. Островского, 40'),
       ('2023-11-27 14:30:00', 'processing', 12, 2, 2, 125000, 'ул. Гончарова, 45'),
       ('2023-11-28 18:00:00', 'shipped', 13, 3, 3, 115000, 'ул. Тургенева, 50'),
       ('2023-11-29 12:00:00', 'completed', 14, 1, 2, 135000, 'ул. Лескова, 55'),
       ('2023-11-30 16:30:00', 'canceled', 15, 2, 3, 120000, 'ул. Салтыкова-Щедрина, 60');

COPY order_items FROM '/var/run/postgres/data/order_items.csv' csv header;