-- User table (10 entries)
INSERT INTO user (userid, username, email, password, firstname, lastname, dob)
VALUES
    (1, 'user1', 'user1@example.com', 'password1', 'John', 'Doe', '1990-01-15'),
    (2, 'user2', 'user2@example.com', 'password2', 'Alice', 'Smith', '1985-06-21'),
    (3, 'user3', 'user3@example.com', 'password3', 'Robert', 'Johnson', '1995-03-08'),
    (4, 'user4', 'user4@example.com', 'password4', 'Emily', 'Brown', '1980-12-04'),
    (5, 'user5', 'user5@example.com', 'password5', 'Michael', 'Lee', '1992-10-17'),
    (6, 'user6', 'user6@example.com', 'password6', 'Sarah', 'Wilson', '1989-07-29'),
    (7, 'user7', 'user7@example.com', 'password7', 'Daniel', 'Evans', '1998-04-12'),
    (8, 'user8', 'user8@example.com', 'password8', 'Olivia', 'Clark', '1993-11-03'),
    (9, 'user9', 'user9@example.com', 'password9', 'William', 'Taylor', '1987-09-23'),
    (10, 'user10', 'user10@example.com', 'password10', 'Sophia', 'Adams', '1997-02-14');

-- Deliveryperson table (10 entries)
INSERT INTO deliveryperson (userid, username, email, password, firstname, lastname, dob)
VALUES
    (11, 'delivery1', 'delivery1@example.com', 'password1', 'David', 'Wilson', '1983-08-12'),
    (12, 'delivery2', 'delivery2@example.com', 'password2', 'Emma', 'Moore', '1982-05-19'),
    (13, 'delivery3', 'delivery3@example.com', 'password3', 'Liam', 'Anderson', '1986-07-28'),
    (14, 'delivery4', 'delivery4@example.com', 'password4', 'Ava', 'Thomas', '1990-04-03'),
    (15, 'delivery5', 'delivery5@example.com', 'password5', 'Noah', 'Harris', '1984-09-07'),
    (16, 'delivery6', 'delivery6@example.com', 'password6', 'Olivia', 'Martin', '1981-02-14'),
    (17, 'delivery7', 'delivery7@example.com', 'password7', 'Elijah', 'Jackson', '1989-11-21'),
    (18, 'delivery8', 'delivery8@example.com', 'password8', 'Mia', 'Robinson', '1987-12-25'),
    (19, 'delivery9', 'delivery9@example.com', 'password9', 'James', 'White', '1985-03-31'),
    (20, 'delivery10', 'delivery10@example.com', 'password10', 'Sophia', 'Lopez', '1992-06-09');

-- Addresses table (10 entries)
INSERT INTO addresses (addressid, userid, street, city, state, country, postalcode)
VALUES
    (1, 1, '123 Main St', 'New York', 'NY', 'USA', 10001),
    (2, 2, '456 Elm St', 'Los Angeles', 'CA', 'USA', 90001),
    (3, 3, '789 Oak St', 'Chicago', 'IL', 'USA', 60601),
    (4, 4, '101 Pine St', 'Houston', 'TX', 'USA', 77001),
    (5, 5, '222 Birch St', 'Miami', 'FL', 'USA', 33101),
    (6, 6, '333 Cedar St', 'San Francisco', 'CA', 'USA', 94101),
    (7, 7, '444 Maple St', 'Boston', 'MA', 'USA', 02101),
    (8, 8, '555 Spruce St', 'Dallas', 'TX', 'USA', 75201),
    (9, 9, '666 Redwood St', 'Atlanta', 'GA', 'USA', 30301),
    (10, 10, '777 Willow St', 'Seattle', 'WA', 'USA', 98101);

-- Product table (10 entries)
INSERT INTO product (productid, productname, description, price, stockqty, categoryid)
VALUES
    (1, 'Product 1', 'Description 1', 19.99, 100, 1),
    (2, 'Product 2', 'Description 2', 29.99, 150, 2),
    (3, 'Product 3', 'Description 3', 9.99, 75, 1),
    (4, 'Product 4', 'Description 4', 39.99, 50, 3),
    (5, 'Product 5', 'Description 5', 49.99, 200, 4),
    (6, 'Product 6', 'Description 6', 14.99, 120, 2),
    (7, 'Product 7', 'Description 7', 24.99, 80, 1),
    (8, 'Product 8', 'Description 8', 34.99, 60, 3),
    (9, 'Product 9', 'Description 9', 44.99, 90, 2),
    (10, 'Product 10', 'Description 10', 19.99, 110, 4);

-- Order table (10 entries)
INSERT INTO "order" (orderid, userid, orderdate, totalamt, shippingaddressid, paymentmethodid)
VALUES
    (1, 1, CURRENT_DATE - INTERVAL '5 days', 49.98, 1, 1),
    (2, 2, CURRENT_DATE - INTERVAL '3 days', 59.98, 2, 2),
    (3, 3, CURRENT_DATE - INTERVAL '7 days', 29.97, 3, 3),
    (4, 4, CURRENT_DATE - INTERVAL '2 days', 119.96, 4, 4),
    (5, 5, CURRENT_DATE - INTERVAL '6 days', 99.95, 5, 5),
    (6, 6, CURRENT_DATE - INTERVAL '4 days', 29.94, 6, 6),
    (7, 7, CURRENT_DATE - INTERVAL '1 day', 49.93, 7, 7),
    (8, 8, CURRENT_DATE - INTERVAL '3 days', 69.92, 8, 8),
    (9, 9, CURRENT_DATE - INTERVAL '7 days', 89.91, 9, 9),
    (10, 10, CURRENT_DATE - INTERVAL '5 days', 39.90, 10, 10);

-- Reviews table (10 entries)
INSERT INTO reviews (reviewid, userid, productid, rating, reviewtext, reviewdate)
VALUES
    (1, 1, 1, 5, 'Great product!', CURRENT_DATE - INTERVAL '2 days'),
    (2, 2, 2, 4, 'Good value for the price', CURRENT_DATE - INTERVAL '4 days'),
    (3, 3, 3, 3, 'Average product', CURRENT_DATE - INTERVAL '1 day'),
    (4, 4, 4, 5, 'Excellent quality', CURRENT_DATE - INTERVAL '3 days'),
    (5, 5, 5, 2, 'Not satisfied', CURRENT_DATE - INTERVAL '5 days'),
    (6, 6, 6, 4, 'Would buy again', CURRENT_DATE - INTERVAL '2 days'),
    (7, 7, 7, 3, 'Just okay', CURRENT_DATE - INTERVAL '6 days'),
    (8, 8, 8, 5, 'Impressive!', CURRENT_DATE - INTERVAL '4 days'),
    (9, 9, 9, 4, 'Decent product', CURRENT_DATE - INTERVAL '1 day'),
    (10, 10, 10, 2, 'Disappointed', CURRENT_DATE - INTERVAL '7 days');

-- Coupon table (10 entries)
INSERT INTO coupon (couponid, couponcode, discountpercentage, expirationdate, orderid)
VALUES
    (1, 1001, 10.0, CURRENT_DATE + INTERVAL '30 days', 1),
    (2, 1002, 15.0, CURRENT_DATE + INTERVAL '60 days', 2),
    (3, 1003, 20.0, CURRENT_DATE + INTERVAL '45 days', 3),
    (4, 1004, 25.0, CURRENT_DATE + INTERVAL '90 days', 4),
    (5, 1005, 30.0, CURRENT_DATE + INTERVAL '75 days', 5),
    (6, 1006, 5.0, CURRENT_DATE + INTERVAL '15 days', 6),
    (7, 1007, 12.0, CURRENT_DATE + INTERVAL '40 days', 7),
    (8, 1008, 8.0, CURRENT_DATE + INTERVAL '25 days', 8),
    (9, 1009, 14.0, CURRENT_DATE + INTERVAL '35 days', 9),
    (10, 1010, 18.0, CURRENT_DATE + INTERVAL '50 days', 10);

-- Seller table (10 entries)
INSERT INTO seller (sellerid, sellername, selleremail, sellerphone)
VALUES
    (1, 'Seller 1', 'seller1@example.com', 1234567890),
    (2, 'Seller 2', 'seller2@example.com', 2345678901),
    (3, 'Seller 3', 'seller3@example.com', 3456789012),
    (4, 'Seller 4', 'seller4@example.com', 4567890123),
    (5, 'Seller 5', 'seller5@example.com', 5678901234),
    (6, 'Seller 6', 'seller6@example.com', 6789012345),
    (7, 'Seller 7', 'seller7@example.com', 7890123456),
    (8, 'Seller 8', 'seller8@example.com', 8901234567),
    (9, 'Seller 9', 'seller9@example.com', 9012345678),
    (10, 'Seller 10', 'seller10@example.com', 1234567890);

-- Wallet table (10 entries)
INSERT INTO wallet (walletid, userid, balance)
VALUES
    (1, 1, 1000.0),
    (2, 2, 1500.0),
    (3, 3, 750.0),
    (4, 4, 2000.0),
    (5, 5, 3000.0),
    (6, 6, 1200.0),
    (7, 7, 800.0),
    (8, 8, 2200.0),
    (9, 9, 900.0),
    (10, 10, 1100.0);

-- Paymentsmethod table (10 entries)
INSERT INTO paymentsmethod (paymentmethodid, userid, paymenttype, cardnumber, expirydate, billingaddressid)
VALUES
    (1, 1, 'Card', 4000000000000000, CURRENT_DATE + INTERVAL '365 days', 1),
    (2, 2, 'Card', 4000000000000001, CURRENT_DATE + INTERVAL '365 days', 2),
    (3, 3, 'Card', 4000000000000002, CURRENT_DATE + INTERVAL '365 days', 3),
    (4, 4, 'Card', 4000000000000003, CURRENT_DATE + INTERVAL '365 days', 4),
    (5, 5, 'Card', 4000000000000004, CURRENT_DATE + INTERVAL '365 days', 5),
    (6, 6, 'Card', 4000000000000005, CURRENT_DATE + INTERVAL '365 days', 6),
    (7, 7, 'Card', 4000000000000006, CURRENT_DATE + INTERVAL '365 days', 7),
    (8, 8, 'Card', 4000000000000007, CURRENT_DATE + INTERVAL '365 days', 8),
    (9, 9, 'Card', 4000000000000008, CURRENT_DATE + INTERVAL '365 days', 9),
    (10, 10, 'Card', 4000000000000009, CURRENT_DATE + INTERVAL '365 days', 10);

-- Orderitem table (10 entries)
INSERT INTO orderitem (orderitemid, orderid, productid, quantity, subtotal, paymentmethodid)
VALUES
    (1, 1, 1, 2, 39.98, 1),
    (2, 2, 2, 3, 89.97, 2),
    (3, 3, 3, 1, 9.99, 3),
    (4, 4, 4, 5, 199.95, 4),
    (5, 5, 5, 4, 199.96, 5),
    (6, 6, 6, 2, 29.98, 6),
    (7, 7, 7, 3, 74.97, 7),
    (8, 8, 8, 4, 139.96, 8),
    (9, 9, 9, 2, 89.98, 9),
    (10, 10, 10, 5, 99.95, 10);

-- Categories table (10 entries)
INSERT INTO categories (categoryid, category)
VALUES
    (1, 'Category 1'),
    (2, 'Category 2'),
    (3, 'Category 3'),
    (4, 'Category 4'),
    (5, 'Category 5');

-- Shipment table (10 entries)
INSERT INTO shipment (shipmentid, orderid, shipmentdate, estimateddeliverydate, actualdeliverydate, shippingstatus)
VALUES
    (1, 1, CURRENT_DATE - INTERVAL '1 day', CURRENT_DATE + INTERVAL '4 days', CURRENT_DATE + INTERVAL '4 days', 'Shipped'),
    (2, 2, CURRENT_DATE, CURRENT_DATE + INTERVAL '3 days', CURRENT_DATE + INTERVAL '3 days', 'Shipped'),
    (3, 3, CURRENT_DATE - INTERVAL '2 days', CURRENT_DATE + INTERVAL '5 days', CURRENT_DATE + INTERVAL '5 days', 'Shipped'),
    (4, 4, CURRENT_DATE - INTERVAL '3 days', CURRENT_DATE + INTERVAL '2 days', CURRENT_DATE + INTERVAL '2 days', 'Shipped'),
    (5, 5, CURRENT_DATE - INTERVAL '4 days', CURRENT_DATE + INTERVAL '6 days', CURRENT_DATE + INTERVAL '6 days', 'Shipped'),
    (6, 6, CURRENT_DATE - INTERVAL '5 days', CURRENT_DATE + INTERVAL '1 day', CURRENT_DATE + INTERVAL '1 day', 'Shipped'),
    (7, 7, CURRENT_DATE - INTERVAL '6 days', CURRENT_DATE + INTERVAL '7 days', CURRENT_DATE + INTERVAL '7 days', 'Shipped'),
    (8, 8, CURRENT_DATE - INTERVAL '7 days', CURRENT_DATE + INTERVAL '4 days', CURRENT_DATE + INTERVAL '4 days', 'Shipped'),
    (9, 9, CURRENT_DATE - INTERVAL '8 days', CURRENT_DATE + INTERVAL '5 days', CURRENT_DATE + INTERVAL '5 days', 'Shipped'),
    (10, 10, CURRENT_DATE - INTERVAL '9 days', CURRENT_DATE + INTERVAL '3 days', CURRENT_DATE + INTERVAL '3 days', 'Shipped');

-- Sellerproducts table (10 entries)
INSERT INTO sellerproducts (sellerproductid, sellerid, productid)
VALUES
    (1, 1, 1),
    (2, 2, 2),
    (3, 3, 3),
    (4, 4, 4),
    (5, 5, 5),
    (6, 6, 6),
    (7, 7, 7),
    (8, 8, 8),
    (9, 9, 9),
    (10, 10, 10);

-- Wishlistitem table (10 entries)
INSERT INTO wishlistitem (wishlistitemid, wishlistid, productid)
VALUES
    (1, 1, 1),
    (2, 2, 2),
    (3, 3, 3),
    (4, 4, 4),
    (5, 5, 5),
    (6, 6, 6),
    (7, 7, 7),
    (8, 8, 8),
    (9, 9, 9),
    (10, 10, 10);

-- Wishlists table (10 entries)
INSERT INTO wishlists (wishlistid, userid)
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

