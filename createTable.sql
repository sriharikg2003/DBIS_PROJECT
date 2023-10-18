create table user
	(userid		int,
	 username		varchar(255),
	 email		numeric(255),
     password	varchar(255),
     firstname	varchar(255),
     lastname	varchar(255),
     dob Date,
	 primary key (userid)
	);

create table deliveryperson
	(userid		int,
	 username		varchar(255),
	 email		numeric(255),
     password	varchar(255),
     firstname	varchar(255),
     lastname	varchar(255),
     dob Date,
	 primary key (userid)
	);

create table addresses
	(addressid		int, 
	 userid		int, 
	 street		varchar(255),      
     city varchar(255),
     state varchar(255),
     country varchar(255),
     postalcode  int,
	 primary key (addressid)
	);

create table product
	(
        productid  int, 
        productname  varchar(255),  
        description Date,
        price real,
        stockqty int,
        categoryid	  int,
        
	);

create table order
	(
        orderid  int, 
        userid  int,
        orderdate Date,
        totalamt real,
        shippingaddressid int,
        paymentmethodid	  int,
        
	);

create table reviews
	(
        reviewid int,
        userid int,
        productid int,
        rating integer,
        reviewtext varchar(255),
        reviewdate Date,
	);

create table coupon
	(
        couponid int,
        couponcode int,
        discountpercentage real,
        expirationdate Date,
        orderid int,
	);


create table seller
	(
        sellerid int,
        sellername varchar(255),
        selleremail varchar(255),
        sellerphone int,
	);

create table wallet
	(
        walletid int,
        userid int,
        balance real,
	);

create table paymentsmethod
	(
        paymentmethodid int,
        userid int,
        paymenttype varchar(255),
        cardnumber int,
        expirydate Date
        billingaddressid int,
	);

create table orderitem
	(
        orderitemid int,
        orderid int,
        productid int,
        quantity int,
        subtotal real,
        paymentmethodid int,
	);

create table categories
	(
        categoryid int,
        category varchar(255),
	);

create table shipment
	(
        shipmentid int,
        orderid int,
        shipmentdate Date,
        estimateddeliverydate Date,
        actualdeliverydate Date,
        shippingstatus varchar(255)

	);

create table sellerproducts
	(
        sellerproductid int,
        sellerid int,
        productid int,
	);

create table wishlistitem
	(
        wishlistitemid int,
        wishlistid int,
        productid int,
	);


create table wishlists
	(
        wishlistid int,
        userid int,
	);




-- -- ----------------------
-- create table section
-- 	(course_id		varchar(8), 
--          sec_id			varchar(8),
-- 	 semester		varchar(6)
-- 		check (semester in ('Fall', 'Winter', 'Spring', 'Summer')), 
-- 	 year			numeric(4,0) check (year > 1701 and year < 2100), 
-- 	 building		varchar(15),
-- 	 room_number		varchar(7),
-- 	 time_slot_id		varchar(4),
-- 	 primary key (course_id, sec_id, semester, year),
-- 	 foreign key (course_id) references course (course_id)
-- 		on delete cascade,
-- 	 foreign key (building, room_number) references classroom (building, room_number)
-- 		on delete set null
-- 	);

-- create table teaches
-- 	(ID			varchar(5), 
-- 	 course_id		varchar(8),
-- 	 sec_id			varchar(8), 
-- 	 semester		varchar(6),
-- 	 year			numeric(4,0),
-- 	 primary key (ID, course_id, sec_id, semester, year),
-- 	 foreign key (course_id, sec_id, semester, year) references section (course_id, sec_id, semester, year)
-- 		on delete cascade,
-- 	 foreign key (ID) references instructor (ID)
-- 		on delete cascade
-- 	);

-- create table student
-- 	(ID			varchar(5), 
-- 	 name			varchar(20) not null, 
-- 	 dept_name		varchar(20), 
-- 	 tot_cred		numeric(3,0) check (tot_cred >= 0),
-- 	 primary key (ID),
-- 	 foreign key (dept_name) references department (dept_name)
-- 		on delete set null
-- 	);

-- create table takes
-- 	(ID			varchar(5), 
-- 	 course_id		varchar(8),
-- 	 sec_id			varchar(8), 
-- 	 semester		varchar(6),
-- 	 year			numeric(4,0),
-- 	 grade		        varchar(2),
-- 	 primary key (ID, course_id, sec_id, semester, year),
-- 	 foreign key (course_id, sec_id, semester, year) references section (course_id, sec_id, semester, year)
-- 		on delete cascade,
-- 	 foreign key (ID) references student (ID)
-- 		on delete cascade
-- 	);

-- create table advisor
-- 	(s_ID			varchar(5),
-- 	 i_ID			varchar(5),
-- 	 primary key (s_ID),
-- 	 foreign key (i_ID) references instructor (ID)
-- 		on delete set null,
-- 	 foreign key (s_ID) references student (ID)
-- 		on delete cascade
-- 	);

-- create table time_slot
-- 	(time_slot_id		varchar(4),
-- 	 day			varchar(1),
-- 	 start_hr		numeric(2) check (start_hr >= 0 and start_hr < 24),
-- 	 start_min		numeric(2) check (start_min >= 0 and start_min < 60),
-- 	 end_hr			numeric(2) check (end_hr >= 0 and end_hr < 24),
-- 	 end_min		numeric(2) check (end_min >= 0 and end_min < 60),
-- 	 primary key (time_slot_id, day, start_hr, start_min)
-- 	);

-- create table prereq
-- 	(course_id		varchar(8), 
-- 	 prereq_id		varchar(8),
-- 	 primary key (course_id, prereq_id),
-- 	 foreign key (course_id) references course (course_id)
-- 		on delete cascade,
-- 	 foreign key (prereq_id) references course (course_id)
-- 	);
