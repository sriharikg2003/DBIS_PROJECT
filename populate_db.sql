-- Addresses Table
INSERT INTO addresses (street, city, state, country, postalcode)
VALUES
    ('123 Main St', 'New York', 'NY', 'USA', '10001'),
    ('456 Elm St', 'Los Angeles', 'CA', 'USA', '90001'),
    ('789 Oak St', 'Chicago', 'IL', 'USA', '60601'),
    ('101 Pine St', 'San Francisco', 'CA', 'USA', '94101'),
    ('555 Cedar St', 'Miami', 'FL', 'USA', '33101'),
    ('999 Maple St', 'Seattle', 'WA', 'USA', '98101'),
    ('222 Birch St', 'Boston', 'MA', 'USA', '02101'),
    ('333 Spruce St', 'Austin', 'TX', 'USA', '73301'),
    ('777 Willow St', 'Denver', 'CO', 'USA', '80201'),
    ('888 Redwood St', 'Atlanta', 'GA', 'USA', '30301');

-- Users Table
INSERT INTO users (username, email, password, firstname, lastname, addressid, dob, usertype)
VALUES
    ('john_doe', 'john.doe@email.com', 'password123', 'John', 'Doe', 1, '1990-01-15', 'customer'),
    ('jane_smith', 'jane.smith@email.com', 'secret456', 'Jane', 'Smith', 2, 'delivery-person'),
    ('alice_green', 'alice.green@email.com', 'green123', 'Alice', 'Green', 3, 'seller'),
    ('bob_jones', 'bob.jones@email.com', 'jones456', 'Bob', 'Jones', 1, 'customer'),
    ('susan_white', 'susan.white@email.com', 'whitepass', 'Susan', 'White', 4, 'customer'),
    ('david_brown', 'david.brown@email.com', 'brown123', 'David', 'Brown', 3, 'seller'),
    ('sarah_harris', 'sarah.harris@email.com', 'sarah789', 'Sarah', 'Harris', 6, 'customer'),
    ('james_wilson', 'james.wilson@email.com', 'wilson456', 'James', 'Wilson', 5, 'seller'),
    ('emily_adams', 'emily.adams@email.com', 'adams123', 'Emily', 'Adams', 4, 'customer'),
    ('michael_clark', 'michael.clark@email.com', 'michael456', 'Michael', 'Clark', 6, 'seller');


-- Categories Table
INSERT INTO categories (category)
VALUES
    ('Electronics'),
    ('Clothing'),
    ('Home and Garden'),
    ('Books'),
    ('Sports and Outdoors'),
    ('Toys and Games'),
    ('Health and Beauty'),
    ('Food and Drink'),
    ('Automotive'),
    ('Office Supplies');

-- Product Table
INSERT INTO product (productname, description, price, stockqty, categoryid)
VALUES
    ('Smartphone', 'High-end smartphone with great features', 599.99, 50, 1),
    ('T-shirt', 'Cotton t-shirt in various colors', 19.99, 100, 2),
    ('Lawn Mower', 'Electric lawn mower for small yards', 199.99, 30, 3),
    ('The Great Gatsby', 'Classic novel by F. Scott Fitzgerald', 9.99, 75, 4),
    ('Soccer Ball', 'Official-size soccer ball', 24.99, 40, 5),
    ('Board Game', 'Family board game for 4 players', 39.99, 20, 6),
    ('Shampoo', 'Moisturizing shampoo for all hair types', 8.99, 60, 7),
    ('Coffee Beans', 'Premium Arabica coffee beans', 12.99, 100, 8),
    ('Car Battery', '12V car battery for most vehicles', 69.99, 15, 9),
    ('Printer Paper', 'High-quality printer paper, 500 sheets', 7.99, 50, 10);

-- Reviews Table
INSERT INTO reviews (userid, productid, rating, reviewtext, reviewdate)
VALUES
    (1, 1, 5, 'I love this phone!', '2023-10-15'),
    (2, 2, 4, 'Comfortable and stylish.', '2023-10-16'),
    (3, 3, 4, 'Great mower for the price.', '2023-10-17'),
    (4, 4, 5, 'A timeless classic.', '2023-10-18'),
    (5, 5, 4, 'Good for practicing.', '2023-10-19'),
    (6, 6, 5, 'Fun game for the family.', '2023-10-20'),
    (7, 7, 3, 'Nice scent, but not outstanding.', '2023-10-21'),
    (8, 8, 5, 'Excellent coffee!', '2023-10-22'),
    (9, 9, 4, 'Good replacement battery.', '2023-10-23'),
    (10, 10, 4, 'Quality paper at a good price.', '2023-10-24');

-- Wallet Table
INSERT INTO wallet (userid, balance)
VALUES
    (1, 500.00),
    (2, 100.00),
    (3, 1000.00),
    (4, 250.00),
    (5, 150.00),
    (6, 800.00),
    (7, 75.00),
    (8, 120.00),
    (9, 350.00),
    (10, 50.00);

-- Paymentsmethod Table
INSERT INTO paymentsmethod (userid, paymenttype)
VALUES
    (1, 'Credit Card'),
    (2, 'PayPal'),
    (3, 'Bank Transfer'),
    (4, 'Debit Card'),
    (5, 'Cash on Delivery'),
    (6, 'Credit Card'),
    (7, 'PayPal'),
    (8, 'Bank Transfer'),
    (9, 'Debit Card'),
    (10, 'Cash on Delivery');

-- Orders Table
INSERT INTO orders (userid, orderdate, totalamt, shippingaddressid, paymentmethodid)
VALUES
    (1, '2023-10-15', 599.99, 1, 1),
    (2, '2023-10-16', 39.98, 2, 2),
    (3, '2023-10-17', 199.99, 3, 3),
    (4, '2023-10-18', 19.98, 4, 4),
    (5, '2023-10-19', 99.96, 5, 5),
    (6, '2023-10-20', 79.98, 6, 6),
    (7, '2023-10-21', 35.96, 7, 7),
    (8, '2023-10-22', 25.98, 8, 8),
    (9, '2023-10-23', 139.98, 9, 9),
    (10, '2023-10-24', 7.99, 10, 10);

-- Orderitem Table
INSERT INTO orderitem (orderid, productid, quantity)
VALUES
    (1, 1, 1),
    (2, 2, 2),
    (3, 3, 1),
    (4, 4, 3),
    (5, 5, 2),
    (6, 6, 1),
    (7, 7, 4),
    (8, 8, 5),
    (9, 9, 1),
    (10, 10, 2);

-- Shipment Table
INSERT INTO shipment (orderid, shipmentdate, estimateddeliverydate, actualdeliverydate, shippingstatus, deliverypersonID)
VALUES
    (1, '2023-10-16', '2023-10-20', '2023-10-21', 'Delivered', 2),
    (2, '2023-10-17', '2023-10-21', '2023-10-22', 'Delivered', 3),
    (3, '2023-10-18', '2023-10-22', '2023-10-23', 'Delivered', 4),
    (4, '2023-10-19', '2023-10-23', '2023-10-24', 'In Transit', 5),
    (5, '2023-10-20', '2023-10-24', NULL, 'In Transit', NULL),
    (6, '2023-10-21', '2023-10-25', NULL, 'In Transit', NULL),
    (7, '2023-10-22', '2023-10-26', NULL, 'In Transit', NULL),
    (8, '2023-10-23', '2023-10-27', NULL, 'In Transit', NULL),
    (9, '2023-10-24', '2023-10-28', NULL, 'In Transit', NULL),
    (10, '2023-10-25', '2023-10-29', NULL, 'In Transit', NULL);

-- Coupon Table
INSERT INTO coupon (couponcode, discountpercentage, expirationdate, orderid)
VALUES
    (12345, 10.0, '2023-10-31', 1),
    (54321, 5.0, '2023-10-31', 2),
    (11111, 15.0, '2023-10-31', 3),
    (22222, 8.0, '2023-10-31', 4),
    (33333, 20.0, '2023-10-31', 5),
    (44444, 12.0, '2023-10-31', 6),
    (55555, 7.0, '2023-10-31', 7),
    (66666, 10.0, '2023-10-31', 8),
    (77777, 10.0, '2023-10-31', 9),
    (88888, 15.0, '2023-10-31', 10);

-- Sellerproducts Table
INSERT INTO sellerproducts (sellerid, productid)
VALUES
    (3, 1),
    (6, 2),
    (3, 3),
    (10, 4),
    (7, 5),
    (6, 6),
    (9, 7),
    (4, 8),
    (10, 9),
    (3, 10);

-- Wishlists Table
INSERT INTO wishlists (userid)
VALUES
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

-- Wishlistitem Table
INSERT INTO wishlistitem (wishlistid, productid)
VALUES
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
