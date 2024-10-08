-- Drop the 'wishlistitem' table
DROP TABLE IF EXISTS wishlistitem;

-- Drop the 'wishlists' table
DROP TABLE IF EXISTS wishlists;

-- Drop the 'sellerproducts' table
DROP TABLE IF EXISTS sellerproducts;

-- Drop the 'coupon' table
DROP TABLE IF EXISTS coupon;

-- Drop the 'shipment' table
DROP TABLE IF EXISTS shipment;

-- Drop the 'orderitem' table
DROP TABLE IF EXISTS orderitem;

-- Drop the 'order' table
DROP TABLE IF EXISTS orders;

-- Drop the 'paymentsmethod' table
DROP TABLE IF EXISTS paymentsmethod;

-- Drop the 'wallet' table
DROP TABLE IF EXISTS wallet;

-- Drop the 'reviews' table
DROP TABLE IF EXISTS reviews;

-- Drop the 'product' table
DROP TABLE IF EXISTS product;

-- Drop the 'categories' table
DROP TABLE IF EXISTS categories;

-- Drop the 'users' table
DROP TABLE IF EXISTS users;

-- Drop the 'addresses' table
DROP TABLE IF EXISTS addresses;

-- Drop the ENUM type if you no longer need it
DROP TYPE IF EXISTS USERTYPE_ENUM;



-- Addresses table
CREATE TABLE addresses (
    addressid SERIAL PRIMARY KEY,
    street VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(255),
    country VARCHAR(255),
    postalcode VARCHAR(10)
);

CREATE TYPE USERTYPE_ENUM AS ENUM ('customer', 'delivery-person', 'seller', 'owner', 'admin');

-- Users table
CREATE TABLE users (
    userid SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    firstname VARCHAR(255) NOT NULL,
    lastname VARCHAR(255) NOT NULL,
    addressid int,
    dob DATE NOT NULL,
    usertype USERTYPE_ENUM NOT NULL,
    FOREIGN KEY (addressid) REFERENCES addresses(addressid)
);


-- Categories table
CREATE TABLE categories (
    categoryid SERIAL PRIMARY KEY,
    category VARCHAR(255)
);

-- Product table
CREATE TABLE product (
    productid SERIAL PRIMARY KEY,
    productname VARCHAR(255),
    description TEXT,
    price REAL,
    stockqty INT,
    categoryid INT,
    sellerid int,
    FOREIGN KEY (sellerid) REFERENCES users(userid),
    FOREIGN KEY (categoryid) REFERENCES categories(categoryid)
);

-- Reviews table
CREATE TABLE reviews (
    reviewid SERIAL PRIMARY KEY,
    userid int,
    productid int,
    rating int,
    reviewtext TEXT,
    reviewdate timestamp,
    FOREIGN KEY (userid) REFERENCES users(userid),
    FOREIGN KEY (productid) REFERENCES product(productid)
);

-- Wallet table
CREATE TABLE wallet (
    walletid SERIAL PRIMARY KEY,
    userid int,
    balance REAL,
    FOREIGN KEY (userid) REFERENCES users(userid)
);

-- Paymentsmethod table
CREATE TABLE paymentsmethod (
    paymentmethodid SERIAL PRIMARY KEY,
    userid int,
    paymenttype VARCHAR(255),
    FOREIGN KEY (userid) REFERENCES users(userid)
);


-- Coupon table
CREATE TABLE coupon (
    couponid SERIAL PRIMARY KEY,
    couponcode INT,
    discountpercentage REAL,
    expirationdate timestamp
    -- orderid SERIAL,
    -- FOREIGN KEY (orderid) REFERENCES orders(orderid)
);


-- Order table
CREATE TABLE orders (
    orderid SERIAL PRIMARY KEY,
    userid int,
    orderdate timestamp,
    totalamt REAL,
    couponid int default 0,
    shippingaddressid int,
    paymentmethodid int,
    FOREIGN KEY (userid) REFERENCES users(userid),
    FOREIGN KEY (shippingaddressid) REFERENCES addresses(addressid),
    FOREIGN KEY (paymentmethodid) REFERENCES paymentsmethod(paymentmethodid)
);

-- Orderitem table
CREATE TABLE orderitem (
    orderitemid SERIAL PRIMARY KEY,
    orderid int,
    productid int,
    quantity INT,
    FOREIGN KEY (orderid) REFERENCES orders(orderid),
    FOREIGN KEY (productid) REFERENCES product(productid)
);

-- Shipment table
CREATE TABLE shipment (
    shipmentid SERIAL PRIMARY KEY,
    orderid int,
    shipmentdate timestamp,
    estimateddeliverydate timestamp,
    actualdeliverydate timestamp,
    shippingstatus VARCHAR(255),
    deliverypersonID int,
    FOREIGN KEY (orderid) REFERENCES orders(orderid),
    FOREIGN KEY (deliverypersonID) REFERENCES users(userid)
);



-- Wishlists table
CREATE TABLE wishlists (
    wishlistid SERIAL PRIMARY KEY,
    userid int,
    FOREIGN KEY (userid) REFERENCES users(userid)
);

-- Wishlistitem table
CREATE TABLE wishlistitem (
    wishlistitemid SERIAL PRIMARY KEY,
    wishlistid int,
    productid int,
    FOREIGN KEY (wishlistid) REFERENCES wishlists(wishlistid),
    FOREIGN KEY (productid) REFERENCES product(productid)
);