-- Drop tables in reverse order to avoid foreign key constraints

-- Drop Wishlistitem table
DROP TABLE IF EXISTS wishlistitem;

-- Drop Wishlists table
DROP TABLE IF EXISTS wishlists;

-- Drop Sellerproducts table
DROP TABLE IF EXISTS sellerproducts;

-- Drop Coupon table
DROP TABLE IF EXISTS coupon;

-- Drop Shipment table
DROP TABLE IF EXISTS shipment;

-- Drop Orderitem table
DROP TABLE IF EXISTS orderitem;

-- Drop Order table
DROP TABLE IF EXISTS "order";

-- Drop Paymentsmethod table
DROP TABLE IF EXISTS paymentsmethod;

-- Drop Wallet table
DROP TABLE IF EXISTS wallet;

-- Drop Seller table
DROP TABLE IF EXISTS seller;

-- Drop Reviews table
DROP TABLE IF EXISTS reviews;

-- Drop Product table
DROP TABLE IF EXISTS product;

-- Drop Categories table
DROP TABLE IF EXISTS categories;

-- Drop Deliveryperson table
DROP TABLE IF EXISTS deliveryperson;

-- Drop Users table
DROP TABLE IF EXISTS users;

-- Drop Addresses table
DROP TABLE IF EXISTS addresses;


-- Addresses table
CREATE TABLE addresses (
    addressid SERIAL PRIMARY KEY,
    street VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(255),
    country VARCHAR(255),
    postalcode VARCHAR(10)
);

-- Users table
CREATE TABLE users (
    userid SERIAL PRIMARY KEY,
    username VARCHAR(255),
    email VARCHAR(255),
    password VARCHAR(255),
    firstname VARCHAR(255),
    lastname VARCHAR(255),
    addressid INT,
    dob DATE,
    FOREIGN KEY (addressid) REFERENCES addresses(addressid)
);

-- Deliveryperson table
CREATE TABLE deliveryperson (
    userid SERIAL PRIMARY KEY,
    username VARCHAR(255),
    email VARCHAR(255),
    password VARCHAR(255),
    firstname VARCHAR(255),
    lastname VARCHAR(255),
    dob DATE
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
    FOREIGN KEY (categoryid) REFERENCES categories(categoryid)
);

-- Reviews table
CREATE TABLE reviews (
    reviewid SERIAL PRIMARY KEY,
    userid INT,
    productid INT,
    rating INT,
    reviewtext TEXT,
    reviewdate DATE,
    FOREIGN KEY (userid) REFERENCES users(userid),
    FOREIGN KEY (productid) REFERENCES product(productid)
);

-- Seller table
CREATE TABLE seller (
    sellerid SERIAL PRIMARY KEY,
    sellername VARCHAR(255),
    selleremail VARCHAR(255),
    sellerpassword VARCHAR(255),
    sellerphone VARCHAR(20),
    addressid INT,
    FOREIGN KEY (addressid) REFERENCES addresses(addressid)
);

-- Wallet table
CREATE TABLE wallet (
    walletid SERIAL PRIMARY KEY,
    userid INT,
    balance REAL,
    FOREIGN KEY (userid) REFERENCES users(userid)
);

-- Paymentsmethod table
CREATE TABLE paymentsmethod (
    paymentmethodid SERIAL PRIMARY KEY,
    userid INT,
    paymenttype VARCHAR(255),
    FOREIGN KEY (userid) REFERENCES users(userid)
);

-- Order table
CREATE TABLE "order" (
    orderid SERIAL PRIMARY KEY,
    userid INT,
    orderdate DATE,
    totalamt REAL,
    shippingaddressid INT,
    paymentmethodid INT,
    FOREIGN KEY (userid) REFERENCES users(userid),
    FOREIGN KEY (shippingaddressid) REFERENCES addresses(addressid),
    FOREIGN KEY (paymentmethodid) REFERENCES paymentsmethod(paymentmethodid)
);

-- Orderitem table
CREATE TABLE orderitem (
    orderitemid SERIAL PRIMARY KEY,
    orderid INT,
    productid INT,
    quantity INT,
    subtotal REAL,
    paymentmethodid INT,
    FOREIGN KEY (orderid) REFERENCES "order"(orderid),
    FOREIGN KEY (productid) REFERENCES product(productid),
    FOREIGN KEY (paymentmethodid) REFERENCES paymentsmethod(paymentmethodid)
);

-- Shipment table
CREATE TABLE shipment (
    shipmentid SERIAL PRIMARY KEY,
    orderid INT,
    shipmentdate DATE,
    estimateddeliverydate DATE,
    actualdeliverydate DATE,
    shippingstatus VARCHAR(255),
    UserID INT,
    FOREIGN KEY (orderid) REFERENCES "order"(orderid),
    FOREIGN KEY (UserID) REFERENCES deliveryperson(userid)
);

-- Coupon table
CREATE TABLE coupon (
    couponid SERIAL PRIMARY KEY,
    couponcode INT,
    discountpercentage REAL,
    expirationdate DATE,
    orderid INT,
    FOREIGN KEY (orderid) REFERENCES "order"(orderid)
);

-- Sellerproducts table
CREATE TABLE sellerproducts (
    sellerproductid SERIAL PRIMARY KEY,
    sellerid INT,
    productid INT,
    FOREIGN KEY (sellerid) REFERENCES seller(sellerid),
    FOREIGN KEY (productid) REFERENCES product(productid)
);

-- Wishlists table
CREATE TABLE wishlists (
    wishlistid SERIAL PRIMARY KEY,
    userid INT,
    FOREIGN KEY (userid) REFERENCES users(userid)
);

-- Wishlistitem table
CREATE TABLE wishlistitem (
    wishlistitemid SERIAL PRIMARY KEY,
    wishlistid INT,
    productid INT,
    FOREIGN KEY (wishlistid) REFERENCES wishlists(wishlistid),
    FOREIGN KEY (productid) REFERENCES product(productid)
);