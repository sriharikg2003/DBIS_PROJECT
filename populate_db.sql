-- Addresses table
INSERT INTO addresses (street, city, state, country, postalcode)
VALUES
    ('123 Main St', 'New York', 'NY', 'USA', 10001),
    ('456 Elm St', 'Los Angeles', 'CA', 'USA', 90001),
    ('789 Oak St', 'Chicago', 'IL', 'USA', 60601),
    ('321 Elm St', 'San Francisco', 'CA', 'USA', 94101),
    ('555 Pine St', 'Miami', 'FL', 'USA', 33101),
    ('987 Maple St', 'Houston', 'TX', 'USA', 77001),
    ('222 Birch St', 'Seattle', 'WA', 'USA', 98101),
    ('777 Cedar St', 'Boston', 'MA', 'USA', 02201),
    ('444 Spruce St', 'Dallas', 'TX', 'USA', 75201),
    ('888 Willow St', 'Atlanta', 'GA', 'USA', 30301);

-- Users table
INSERT INTO users (username, email, password, firstname, lastname, addressid, dob)
VALUES
    ('user1', 'user1@email.com', 'password1', 'John', 'Doe', 1, '1990-01-15'),
    ('user2', 'user2@email.com', 'password2', 'Jane', 'Smith', 2, '1985-03-20'),
    ('user3', 'user3@email.com', 'password3', 'Robert', 'Johnson', 3, '1995-07-10'),
    ('user4', 'user4@email.com', 'password4', 'Sarah', 'Wilson', 4, '1988-11-05'),
    ('user5', 'user5@email.com', 'password5', 'Michael', 'Brown', 5, '1980-09-25'),
    ('user6', 'user6@email.com', 'password6', 'Emily', 'Davis', 6, '1992-02-18'),
    ('user7', 'user7@email.com', 'password7', 'Daniel', 'Lee', 7, '1987-06-30'),
    ('user8', 'user8@email.com', 'password8', 'Olivia', 'Garcia', 8, '1994-04-12'),
    ('user9', 'user9@email.com', 'password9', 'William', 'Martinez', 9, '1998-08-03'),
    ('user10', 'user10@email.com', 'password10', 'Sophia', 'Rodriguez', 10, '1982-12-22');

-- Deliveryperson table
INSERT INTO deliveryperson (username, email, password, firstname, lastname, dob)
VALUES
    ('delivery1', 'delivery1@email.com', 'password1', 'Mark', 'Anderson', '1985-07-15'),
    ('delivery2', 'delivery2@email.com', 'password2', 'Lisa', 'Williams', '1990-03-20'),
    ('delivery3', 'delivery3@email.com', 'password3', 'James', 'Brown', '1992-09-10'),
    ('delivery4', 'delivery4@email.com', 'password4', 'Mia', 'Smith', '1988-11-05'),
    ('delivery5', 'delivery5@email.com', 'password5', 'Liam', 'Johnson', '1980-02-25'),
    ('delivery6', 'delivery6@email.com', 'password6', 'Ella', 'Davis', '1995-12-18'),
    ('delivery7', 'delivery7@email.com', 'password7', 'Noah', 'Wilson', '1987-06-30'),
    ('delivery8', 'delivery8@email.com', 'password8', 'Ava', 'Garcia', '1982-05-12'),
    ('delivery9', 'delivery9@email.com', 'password9', 'Liam', 'Brown', '1998-08-03'),
    ('delivery10', 'delivery10@email.com', 'password10', 'Emma', 'Miller', '1993-04-22');

-- Categories table
INSERT INTO categories (category)
VALUES
    ('Electronics'),
    ('Clothing'),
    ('Books'),
    ('Home & Kitchen'),
    ('Toys'),
    ('Sports & Outdoors'),
    ('Beauty & Personal Care'),
    ('Automotive'),
    ('Health & Wellness'),
    ('Garden & Outdoor');

-- Product table
INSERT INTO product (productname, description, price, stockqty, categoryid)
VALUES
    ('Smartphone', 'Latest model with high-resolution camera.', 599.99, 100, 1),
    ('T-shirt', 'Comfortable and stylish cotton t-shirt.', 19.99, 300, 2),
    ('Bestseller Novel', 'A gripping novel by a renowned author.', 24.99, 50, 3),
    ('Cookware Set', 'Non-stick cookware set for your kitchen.', 129.99, 75, 4),
    ('Toy Train Set', 'Entertainment for kids with a complete train set.', 49.99, 60, 5),
    ('Tennis Racket', 'Professional-grade tennis racket.', 79.99, 40, 6),
    ('Skincare Kit', 'Complete skincare regimen for a healthy skin.', 39.99, 80, 7),
    ('Car Oil Change Kit', 'Essential kit for changing your car oil.', 29.99, 30, 8),
    ('Vitamin Supplements', 'Boost your health with these vitamins.', 9.99, 100, 9),
    ('Garden Tools Set', 'Quality tools for your gardening needs.', 69.99, 45, 10);

-- Reviews table
INSERT INTO reviews (userid, productid, rating, reviewtext, reviewdate)
VALUES
    (1, 1, 5, 'Great smartphone with an amazing camera!', '2023-01-18'),
    (2, 3, 4, 'Enjoyed reading this novel, highly recommended.', '2023-02-10'),
    (4, 2, 5, 'Love the quality of these t-shirts.', '2023-02-15'),
    (3, 6, 4, 'Good tennis racket, suits my needs.', '2023-03-02'),
    (5, 4, 3, 'The cookware set is decent, but not the best.', '2023-03-05'),
    (6, 5, 5, 'Kids love the toy train set, great buy!', '2023-03-10'),
    (8, 9, 5, 'Vitamins have made a difference in my health.', '2023-04-12'),
    (7, 7, 4, 'Skincare kit has improved my skin quality.', '2023-04-20'),
    (10, 10, 4, 'Quality garden tools for gardening enthusiasts.', '2023-05-01'),
    (9, 8, 3, 'The car oil change kit is just average.', '2023-05-05');

-- Seller table
INSERT INTO seller (sellername, selleremail, sellerphone, addressid)
VALUES
    ('Electro Deals', 'electrodeals@email.com', '123-456-7890', 1),
    ('Fashion Trends', 'fashiontrends@email.com', '456-789-1230', 2),
    ('Book Haven', 'bookhaven@email.com', '789-123-4560', 3),
    ('KitchenWares', 'kitchenwares@email.com', '987-654-3210', 4),
    ('Toys Unlimited', 'toysunlimited@email.com', '654-321-7890', 5),
    ('Sports Central', 'sportscentral@email.com', '321-789-4560', 6),
    ('SkinSense', 'skinsense@email.com', '234-567-8901', 7),
    ('AutoPro', 'autopro@email.com', '789-123-2340', 8),
    ('HealthWell', 'healthwell@email.com', '567-890-1234', 9),
    ('Green Gardens', 'greengardens@email.com', '432-345-5678', 10);

-- Wallet table
INSERT INTO wallet (userid, balance)
VALUES
    (1, 500.00),
    (2, 750.00),
    (3, 1000.00),
    (4, 450.00),
    (5, 850.00),
    (6, 400.00),
    (7, 1100.00),
    (8, 200.00),
    (9, 600.00),
    (10, 900.00);

-- Paymentsmethod table
INSERT INTO paymentsmethod (userid, paymenttype)
VALUES
    (1, 'Credit Card'),
    (2, 'PayPal'),
    (3, 'Debit Card'),
    (4, 'Cash on Delivery'),
    (5, 'Credit Card'),
    (6, 'Google Pay'),
    (7, 'Debit Card'),
    (8, 'Apple Pay'),
    (9, 'PayPal'),
    (10, 'Credit Card');

-- Order table
INSERT INTO "order" (userid, orderdate, totalamt, shippingaddressid, paymentmethodid)
VALUES
    (1, '2023-01-20', 599.99, 1, 1),
    (2, '2023-02-25', 24.99, 2, 2),
    (3, '2023-02-28', 129.99, 3, 3),
    (4, '2023-03-05', 79.99, 4, 4),
    (5, '2023-03-10', 29.99, 5, 5),
    (6, '2023-04-15', 49.99, 6, 6),
    (7, '2023-04-20', 39.99, 7, 7),
    (8, '2023-05-01', 9.99, 8, 8),
    (9, '2023-05-05', 69.99, 9, 9),
    (10, '2023-06-10', 29.99, 10, 10);

-- Orderitem table
INSERT INTO orderitem (orderid, productid, quantity, subtotal, paymentmethodid)
VALUES
    (1, 1, 1, 599.99, 1),
    (2, 3, 2, 49.98, 2),
    (3, 2, 3, 74.97, 3),
    (4, 6, 1, 79.99, 4),
    (5, 4, 2, 59.98, 5),
    (6, 5, 1, 49.99, 6),
    (7, 7, 2, 79.98, 7),
    (8, 9, 5, 49.95, 8),
    (9, 10, 1, 69.99, 9),
    (10, 8, 4, 119.96, 10);

-- Shipment table
INSERT INTO shipment (orderid, shipmentdate, estimateddeliverydate, actualdeliverydate, shippingstatus)
VALUES
    (1, '2023-01-22', '2023-01-27', '2023-01-25', 'Shipped'),
    (2, '2023-02-28', '2023-03-05', '2023-03-03', 'Shipped'),
    (3, '2023-03-01', '2023-03-08', '2023-03-06', 'Shipped'),
    (4, '2023-03-07', '2023-03-12', '2023-03-10', 'Shipped'),
    (5, '2023-03-12', '2023-03-18', '2023-03-15', 'Shipped'),
    (6, '2023-04-17', '2023-04-22', '2023-04-20', 'Shipped'),
    (7, '2023-04-22', '2023-04-28', '2023-04-25', 'Shipped'),
    (8, '2023-05-07', '2023-05-12', '2023-05-10', 'Shipped'),
    (9, '2023-05-12', '2023-05-18', '2023-05-15', 'Shipped'),
    (10, '2023-06-17', '2023-06-22', '2023-06-20', 'Shipped');

-- Coupon table
INSERT INTO coupon (couponcode, discountpercentage, expirationdate, orderid)
VALUES
    (12345, 10.00, '2023-02-28', 1),
    (54321, 15.00, '2023-03-05', 2),
    (98765, 5.00, '2023-03-10', 3),
    (67890, 20.00, '2023-03-20', 4),
    (12300, 8.00, '2023-03-28', 5),
    (23456, 10.00, '2023-04-15', 6),
    (78900, 12.00, '2023-04-20', 7),
    (34567, 5.00, '2023-05-05', 8),
    (89012, 10.00, '2023-05-12', 9),
    (45678, 15.00, '2023-06-01', 10);

-- Sellerproducts table
INSERT INTO sellerproducts (sellerid, productid)
VALUES
    (1, 1),
    (2, 3),
    (3, 2),
    (4, 6),
    (5, 4),
    (6, 5),
    (7, 7),
    (8, 9),
    (9, 10),
    (10, 8);

-- Wishlists table
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

-- Wishlistitem table
INSERT INTO wishlistitem (wishlistid, productid)
VALUES
    (1, 1),
    (2, 3),
    (3, 2),
    (4, 6),
    (5, 4),
    (6, 5),
    (7, 7),
    (8, 9),
    (9, 10),
    (10, 8);

