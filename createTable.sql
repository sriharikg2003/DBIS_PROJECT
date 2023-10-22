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
DROP TABLE IF EXISTS order;

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
    username VARCHAR(255),
    email VARCHAR(255),
    password VARCHAR(255),
    firstname VARCHAR(255),
    lastname VARCHAR(255),
    addressid SERIAL,
    dob DATE,
    usertype USERTYPE_ENUM,
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
    categoryid SERIAL,
    FOREIGN KEY (categoryid) REFERENCES categories(categoryid)
);

-- Reviews table
CREATE TABLE reviews (
    reviewid SERIAL PRIMARY KEY,
    userid SERIAL,
    productid SERIAL,
    rating SERIAL,
    reviewtext TEXT,
    reviewdate DATE,
    FOREIGN KEY (userid) REFERENCES users(userid),
    FOREIGN KEY (productid) REFERENCES product(productid)
);

-- Wallet table
CREATE TABLE wallet (
    walletid SERIAL PRIMARY KEY,
    userid SERIAL,
    balance REAL,
    FOREIGN KEY (userid) REFERENCES users(userid)
);

-- Paymentsmethod table
CREATE TABLE paymentsmethod (
    paymentmethodid SERIAL PRIMARY KEY,
    userid SERIAL,
    paymenttype VARCHAR(255),
    FOREIGN KEY (userid) REFERENCES users(userid)
);

-- Order table
CREATE TABLE order (
    orderid SERIAL PRIMARY KEY,
    userid SERIAL,
    orderdate DATE,
    totalamt REAL,
    shippingaddressid SERIAL,
    paymentmethodid SERIAL,
    FOREIGN KEY (userid) REFERENCES users(userid),
    FOREIGN KEY (shippingaddressid) REFERENCES addresses(addressid),
    FOREIGN KEY (paymentmethodid) REFERENCES paymentsmethod(paymentmethodid)
);

-- Orderitem table
CREATE TABLE orderitem (
    orderitemid SERIAL PRIMARY KEY,
    orderid SERIAL,
    productid SERIAL,
    quantity INT,
    subtotal REAL,
    paymentmethodid SERIAL,
    FOREIGN KEY (orderid) REFERENCES order(orderid),
    FOREIGN KEY (productid) REFERENCES product(productid),
    FOREIGN KEY (paymentmethodid) REFERENCES paymentsmethod(paymentmethodid)
);

-- Shipment table
CREATE TABLE shipment (
    shipmentid SERIAL PRIMARY KEY,
    orderid SERIAL,
    shipmentdate DATE,
    estimateddeliverydate DATE,
    actualdeliverydate DATE,
    shippingstatus VARCHAR(255),
    UserID SERIAL,
    FOREIGN KEY (orderid) REFERENCES order(orderid),
    FOREIGN KEY (UserID) REFERENCES deliveryperson(userid)
);

-- Coupon table
CREATE TABLE coupon (
    couponid SERIAL PRIMARY KEY,
    couponcode INT,
    discountpercentage REAL,
    expirationdate DATE,
    orderid SERIAL,
    FOREIGN KEY (orderid) REFERENCES order(orderid)
);

-- Sellerproducts table
CREATE TABLE sellerproducts (
    sellerproductid SERIAL PRIMARY KEY,
    sellerid SERIAL,
    productid SERIAL,
    FOREIGN KEY (sellerid) REFERENCES user(userid),
    FOREIGN KEY (productid) REFERENCES product(productid)
);

-- Wishlists table
CREATE TABLE wishlists (
    wishlistid SERIAL PRIMARY KEY,
    userid SERIAL,
    FOREIGN KEY (userid) REFERENCES users(userid)
);

-- Wishlistitem table
CREATE TABLE wishlistitem (
    wishlistitemid SERIAL PRIMARY KEY,
    wishlistid SERIAL,
    productid SERIAL,
    FOREIGN KEY (wishlistid) REFERENCES wishlists(wishlistid),
    FOREIGN KEY (productid) REFERENCES product(productid)
);