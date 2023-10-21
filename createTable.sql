-- Addresses table
CREATE TABLE addresses (
    addressid INT PRIMARY KEY,
    street VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(255),
    country VARCHAR(255),
    postalcode INT
);

-- Users table
CREATE TABLE users (
    userid INT PRIMARY KEY,
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
    userid INT PRIMARY KEY,
    username VARCHAR(255),
    email VARCHAR(255),
    password VARCHAR(255),
    firstname VARCHAR(255),
    lastname VARCHAR(255),
    dob DATE
);

-- Categories table
CREATE TABLE categories (
    categoryid INT PRIMARY KEY,
    category VARCHAR(255)
);

-- Product table
CREATE TABLE product (
    productid INT PRIMARY KEY,
    productname VARCHAR(255),
    description VARCHAR(255),
    price REAL,
    stockqty INT,
    categoryid INT,
    FOREIGN KEY (categoryid) REFERENCES categories(categoryid)
);

-- Reviews table
CREATE TABLE reviews (
    reviewid INT PRIMARY KEY,
    userid INT,
    productid INT,
    rating INT,
    reviewtext VARCHAR(255),
    reviewdate DATE,
    FOREIGN KEY (userid) REFERENCES users(userid),
    FOREIGN KEY (productid) REFERENCES product(productid)
);

-- Seller table
CREATE TABLE seller (
    sellerid INT PRIMARY KEY,
    sellername VARCHAR(255),
    selleremail VARCHAR(255),
    sellerphone INT,
    addressid INT,
    FOREIGN KEY (addressid) REFERENCES addresses(addressid)
);

-- Wallet table
CREATE TABLE wallet (
    walletid INT PRIMARY KEY,
    userid INT,
    balance REAL,
    FOREIGN KEY (userid) REFERENCES users(userid)
);

-- Paymentsmethod table
CREATE TABLE paymentsmethod (
    paymentmethodid INT PRIMARY KEY,
    userid INT,
    paymenttype VARCHAR(255),
    FOREIGN KEY (userid) REFERENCES users(userid)
);

-- Order table
CREATE TABLE "order" (
    orderid INT PRIMARY KEY,
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
    orderitemid INT PRIMARY KEY,
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
    shipmentid INT PRIMARY KEY,
    orderid INT,
    shipmentdate DATE,
    estimateddeliverydate DATE,
    actualdeliverydate DATE,
    shippingstatus VARCHAR(255),
    FOREIGN KEY (orderid) REFERENCES "order"(orderid)
);

-- Coupon table
CREATE TABLE coupon (
    couponid INT PRIMARY KEY,
    couponcode INT,
    discountpercentage REAL,
    expirationdate DATE,
    orderid INT,
    FOREIGN KEY (orderid) REFERENCES "order"(orderid)
);

-- Sellerproducts table
CREATE TABLE sellerproducts (
    sellerproductid INT PRIMARY KEY,
    sellerid INT,
    productid INT,
    FOREIGN KEY (sellerid) REFERENCES seller(sellerid),
    FOREIGN KEY (productid) REFERENCES product(productid)
);

-- Wishlists table
CREATE TABLE wishlists (
    wishlistid INT PRIMARY KEY,
    userid INT,
    FOREIGN KEY (userid) REFERENCES users(userid)
);

-- Wishlistitem table
CREATE TABLE wishlistitem (
    wishlistitemid INT PRIMARY KEY,
    wishlistid INT,
    productid INT,
    FOREIGN KEY (wishlistid) REFERENCES wishlists(wishlistid),
    FOREIGN KEY (productid) REFERENCES product(productid)
);

