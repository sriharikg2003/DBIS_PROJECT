-- Insert 10 entries into the 'addresses' table
INSERT INTO addresses (street, city, state, country, postalcode) VALUES
    ('123 Main St', 'New York', 'NY', 'USA', '10001'),
    ('456 Elm St', 'Los Angeles', 'CA', 'USA', '90001'),
    ('789 Oak St', 'Chicago', 'IL', 'USA', '60601'),
    ('101 Pine St', 'San Francisco', 'CA', 'USA', '94101'),
    ('202 Cedar St', 'Miami', 'FL', 'USA', '33101'),
    ('303 Birch St', 'Houston', 'TX', 'USA', '77001'),
    ('404 Maple St', 'Seattle', 'WA', 'USA', '98101'),
    ('505 Redwood St', 'Atlanta', 'GA', 'USA', '30301'),
    ('606 Spruce St', 'Boston', 'MA', 'USA', '02101'),
    ('707 Walnut St', 'Dallas', 'TX', 'USA', '75201');

-- Insert 10 entries into the 'users' table
INSERT INTO users (username, email, password, firstname, lastname, addressid, dob, usertype) VALUES
    ('user1', 'user1@email.com', 'password1', 'John', 'Doe', 1, '1990-01-01', 'customer'),
    ('user2', 'user2@email.com', 'password2', 'Jane', 'Smith', 2, '1995-02-15', 'delivery-person'),
    ('user3', 'user3@email.com', 'password3', 'Robert', 'Johnson', 3, '1985-05-10', 'seller'),
    ('user4', 'user4@email.com', 'password4', 'Emily', 'Wilson', 4, '1993-09-20', 'customer'),
    ('user5', 'user5@email.com', 'password5', 'Michael', 'Brown', 5, '1997-04-30', 'seller'),
    ('user6', 'user6@email.com', 'password6', 'Linda', 'Davis', 6, '1980-12-05', 'customer'),
    ('user7', 'user7@email.com', 'password7', 'William', 'Miller', 7, '1978-08-15', 'seller'),
    ('user8', 'user8@email.com', 'password8', 'Sarah', 'Harris', 8, '1992-03-25', 'customer'),
    ('user9', 'user9@email.com', 'password9', 'Daniel', 'Martinez', 9, '1996-06-18', 'seller'),
    ('user10', 'user10@email.com', 'password10', 'Laura', 'Lee', 10, '1983-07-12', 'customer');

-- Insert 10 entries into the 'categories' table
INSERT INTO categories (category) VALUES
    ('Electronics'),
    ('Clothing'),
    ('Home & Garden'),
    ('Sports & Outdoors'),
    ('Books'),
    ('Toys & Games'),
    ('Health & Beauty'),
    ('Automotive'),
    ('Food & Groceries'),
    ('Furniture');

-- Insert 10 entries into the 'product' table
INSERT INTO product (productname, description, price, stockqty, categoryid) VALUES
    ('Smartphone', 'High-end smartphone with the latest features.', 699.99, 100, 1),
    ('Jeans', 'Mens slim-fit jeans, available in various sizes.', 49.99, 150, 2),
    ('Garden Tools Set', 'Complete set of gardening tools for enthusiasts.', 69.99, 30, 3),
    ('Tennis Racket', 'Professional-grade tennis racket for power and control.', 129.99, 20, 4),
    ('Best-Selling Novel', 'A gripping novel by a renowned author.', 14.99, 200, 5),
    ('Board Game', 'Classic board game for family fun.', 24.99, 80, 6),
    ('Skincare Kit', 'Complete skincare regimen for radiant skin.', 79.99, 50, 7),
    ('Car Battery', 'High-performance battery for various car models.', 89.99, 40, 8),
    ('Organic Coffee', '100% organic, fair-trade coffee beans.', 12.99, 300, 9),
    ('Sofa', 'Luxurious sofa for your living room.', 499.99, 10, 10);

INSERT INTO reviews (userid, productid, rating, reviewtext, reviewdate) VALUES
    (1, 1, 5, 'Excellent smartphone!', '2023-10-22'),
    (2, 2, 4, 'Great pair of jeans.', '2023-10-22'),
    (3, 3, 4, 'These garden tools are fantastic.', '2023-10-22'),
    (4, 4, 5, 'Outstanding tennis racket!', '2023-10-22'),
    (5, 5, 4, 'Couldnt put this book down.', '2023-10-22'),
    (6, 6, 5, 'Fun board game for the family.', '2023-10-22'),
    (7, 7, 4, 'My skin feels amazing after using this kit.', '2023-10-22'),
    (8, 8, 5, 'The car battery works like a charm.', '2023-10-22'),
    (9, 9, 4, 'Delicious coffee!', '2023-10-22'),
    (10, 10, 5, 'This sofa is incredibly comfortable.', '2023-10-22');

-- Insert 10 entries into the 'wallet' table
INSERT INTO wallet (userid, balance) VALUES
    (1, 500.00),
    (2, 100.00),
    (3, 1000.00),
    (4, 750.00),
    (5, 2000.00),
    (6, 400.00),
    (7, 600.00),
    (8, 900.00),
    (9, 300.00),
    (10, 1200.00);

-- Insert 10 entries into the 'paymentsmethod' table
INSERT INTO paymentsmethod (userid, paymenttype) VALUES
    (1, 'Credit Card'),
    (2, 'PayPal'),
    (3, 'Credit Card'),
    (4, 'PayPal'),
    (5, 'Credit Card'),
    (6, 'PayPal'),
    (7, 'Credit Card'),
    (8, 'PayPal'),
    (9, 'Credit Card'),
    (10, 'PayPal');

-- Insert 10 entries into the 'order' table
INSERT INTO "order" (userid, orderdate, totalamt, shippingaddressid, paymentmethodid) VALUES
    (1, '2023-10-23', 699.99, 1, 1),
    (2, '2023-10-24', 49.99, 2, 2),
    (3, '2023-10-25', 69.99, 3, 3),
    (4, '2023-10-26', 129.99, 4, 4),
    (5, '2023-10-27', 14.99, 5, 5),
    (6, '2023-10-28', 24.99, 6, 6),
    (7, '2023-10-29', 79.99, 7, 7),
    (8, '2023-10-30', 89.99, 8, 8),
    (9, '2023-10-31', 12.99, 9, 9),
    (10, '2023-11-01', 499.99, 10, 10);

-- Insert 10 entries into the 'orderitem' table
INSERT INTO orderitem (orderid, productid, quantity, subtotal, paymentmethodid) VALUES
    (1, 1, 1, 699.99, 1),
    (2, 2, 2, 99.98, 2),
    (3, 3, 1, 69.99, 3),
    (4, 4, 1, 129.99, 4),
    (5, 5, 3, 44.97, 5),
    (6, 6, 1, 24.99, 6),
    (7, 7, 2, 159.98, 7),
    (8, 8, 1, 89.99, 8),
    (9, 9, 4, 51.96, 9),
    (10, 10, 1, 499.99, 10);

-- Insert 10 entries into the 'shipment' table
INSERT INTO shipment (orderid, shipmentdate, estimateddeliverydate, actualdeliverydate, shippingstatus, UserID) VALUES
    (1, '2023-10-24', '2023-10-28', '2023-10-27', 'Shipped', 11),
    (2, '2023-10-25', '2023-10-29', '2023-10-28', 'Shipped', 12),
    (3, '2023-10-26', '2023-10-30', '2023-10-29', 'Shipped', 13),
    (4, '2023-10-27', '2023-10-31', '2023-10-30', 'Shipped', 14),
    (5, '2023-10-28', '2023-11-01', '2023-10-31', 'Shipped', 15),
    (6, '2023-10-29', '2023-11-02', '2023-11-01', 'Shipped', 16),
    (7, '2023-10-30', '2023-11-03', '2023-11-02', 'Shipped', 17),
    (8, '2023-10-31', '2023-11-04', '2023-11-03', 'Shipped', 18),
    (9, '2023-11-01', '2023-11-05', '2023-11-04', 'Shipped', 19),
    (10, '2023-11-02', '2023-11-06', '2023-11-05', 'Shipped', 20);

-- Insert 10 entries into the 'coupon' table
INSERT INTO coupon (couponcode, discountpercentage, expirationdate, orderid) VALUES
    (12345, 10.0, '2023-11-30', 1),
    (54321, 15.0, '2023-12-31', 2),
    (98765, 20.0, '2023-11-30', 3),
    (24680, 25.0, '2023-12-31', 4),
    (13579, 30.0, '2023-11-30', 5),
    (11111, 5.0, '2023-12-31', 6),
    (22222, 10.0, '2023-11-30', 7),
    (33333, 15.0, '2023-12-31', 8),
    (44444, 20.0, '2023-11-30', 9),
    (55555, 25.0, '2023-12-31', 10);

-- Insert 10 entries into the 'sellerproducts' table
INSERT INTO sellerproducts (sellerid, productid) VALUES
    (3, 1),
    (4, 2),
    (5, 3),
    (6, 4),
    (7, 5),
    (8, 6),
    (9, 7),
    (10, 8),
    (1, 9),
    (2, 10);

-- Insert 10 entries into the 'wishlists' table
INSERT INTO wishlists (userid) VALUES
    (1),
    (2),
    (3),
    (4),
    (5),
    (6),
    (7),
    (8),
    (9),
    (10);

-- Insert 10 entries into the 'wishlistitem' table
INSERT INTO wishlistitem (wishlistid, productid) VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7),
    (8, 8),
    (9, 9),
    (10, 10);
