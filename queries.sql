-- Addresses table queries
-- 1. Find the address with the highest number of orders shipped to it.
SELECT shippingaddressid, COUNT(*) AS order_count
FROM "order"
GROUP BY shippingaddressid
ORDER BY order_count DESC
LIMIT 1;

-- 2. Calculate the average distance between addresses in the same city.
SELECT city, AVG(distance) AS avg_distance
FROM (
    SELECT a1.city, ST_Distance(a1.geocoord, a2.geocoord) AS distance
    FROM addresses AS a1
    JOIN addresses AS a2 ON a1.city = a2.city AND a1.addressid < a2.addressid
) AS distances
GROUP BY city;

-- 3. List addresses in descending order of the number of postal code occurrences.
SELECT postalcode, COUNT(*) AS postalcode_count
FROM addresses
GROUP BY postalcode
ORDER BY postalcode_count DESC;

-- 4. Find addresses that are in the same city and state but have different postal codes.
SELECT a1.addressid, a2.addressid
FROM addresses AS a1
JOIN addresses AS a2 ON a1.city = a2.city AND a1.state = a2.state AND a1.postalcode <> a2.postalcode;

-- 5. Retrieve the address with the longest street name.
SELECT addressid, street
FROM addresses
ORDER BY LENGTH(street) DESC
LIMIT 1;

-- 6. List the top 5 cities with the most addresses.
SELECT city, COUNT(*) AS address_count
FROM addresses
GROUP BY city
ORDER BY address_count DESC
LIMIT 5;

-- 7. Find addresses with incomplete or missing information.
SELECT addressid, street, city, state, country, postalcode
FROM addresses
WHERE 
    street IS NULL
    OR city IS NULL
    OR state IS NULL
    OR country IS NULL
    OR postalcode IS NULL;

-- 8. Calculate the total number of unique postal codes.
SELECT COUNT(DISTINCT postalcode) AS unique_postal_codes
FROM addresses;

-- 9. List addresses with the highest total shipping fees.
SELECT shippingaddressid, SUM(totalamt) AS total_shipping_fees
FROM "order"
GROUP BY shippingaddressid
ORDER BY total_shipping_fees DESC
LIMIT 1;

-- 10. Find addresses that have never been used for shipping.
SELECT addressid
FROM addresses
WHERE addressid NOT IN (SELECT DISTINCT shippingaddressid FROM "order");

-- Users table queries
-- 11. Identify users who have never placed an order.
SELECT userid, username
FROM users
WHERE userid NOT IN (SELECT DISTINCT userid FROM "order");

-- 12. List users who have spent the most on a single order.
SELECT userid, MAX(totalamt) AS max_order_total
FROM "order"
GROUP BY userid
ORDER BY max_order_total DESC
LIMIT 1;

-- 13. Calculate the average age of users in each city.
SELECT city, AVG(EXTRACT(YEAR FROM age(dob))) AS avg_age
FROM users
GROUP BY city;

-- 14. Find users with the same first name and last name.
SELECT firstname, lastname, COUNT(*) AS name_count
FROM users
GROUP BY firstname, lastname
HAVING COUNT(*) > 1;

-- 15. Retrieve users who haven't logged in for the last six months.
SELECT userid, username, MAX(last_login) AS last_login
FROM users
GROUP BY userid, username
HAVING MAX(last_login) <= NOW() - INTERVAL '6 months';

-- 16. List users who have placed orders with products from multiple categories.
SELECT u.userid, u.username
FROM users AS u
JOIN "order" AS o ON u.userid = o.userid
JOIN orderitem AS oi ON o.orderid = oi.orderid
JOIN product AS p ON oi.productid = p.productid
GROUP BY u.userid, u.username
HAVING COUNT(DISTINCT p.categoryid) > 1;

-- 17. Find the user with the highest wallet balance.
SELECT userid, username, balance
FROM wallet
JOIN users ON wallet.userid = users.userid
ORDER BY balance DESC
LIMIT 1;

-- 18. Calculate the total amount spent by each user on products in specific categories.
SELECT u.userid, u.username, SUM(oi.subtotal) AS total_spent
FROM users AS u
JOIN "order" AS o ON u.userid = o.userid
JOIN orderitem AS oi ON o.orderid = oi.orderid
JOIN product AS p ON oi.productid = p.productid
WHERE p.categoryid IN (1, 2, 3)  -- Replace with specific category IDs
GROUP BY u.userid, u.username;

-- 19. List users who have placed orders with different payment methods.
SELECT u.userid, u.username
FROM users AS u
JOIN "order" AS o ON u.userid = o.userid
JOIN paymentsmethod AS pm ON o.paymentmethodid = pm.paymentmethodid
GROUP BY u.userid, u.username
HAVING COUNT(DISTINCT pm.paymenttype) > 1;

-- 20. Identify users who have posted reviews with ratings above 4.
SELECT u.userid, u.username
FROM users AS u
JOIN reviews AS r ON u.userid = r.userid
WHERE r.rating > 4;

-- Deliveryperson table queries
-- 21. List all delivery persons with their total completed orders.
SELECT dp.userid, dp.firstname, dp.lastname, COUNT(o.orderid) AS total_completed_orders
FROM deliveryperson AS dp
LEFT JOIN "order" AS o ON dp.userid = o.userid
GROUP BY dp.userid, dp.firstname, dp.lastname;

-- 22. Find delivery persons with the most orders delivered on a single day.
SELECT dp.userid, dp.firstname, dp.lastname, o.deliverydate, COUNT(o.orderid) AS orders_delivered
FROM deliveryperson AS dp
LEFT JOIN "order" AS o ON dp.userid = o.userid
GROUP BY dp.userid, dp.firstname, dp.lastname, o.deliverydate
HAVING COUNT(o.orderid) = (SELECT MAX(order_count) FROM (SELECT COUNT(orderid) AS order_count FROM "order" GROUP BY deliverydate) AS max_orders);

-- 23. Calculate the average time taken by each delivery person to deliver an order.
SELECT dp.userid, dp.firstname, dp.lastname, AVG(EXTRACT(EPOCH FROM (o.actualdeliverydate - o.orderdate))) AS avg_delivery_time
FROM deliveryperson AS dp
LEFT JOIN "order" AS o ON dp.userid = o.userid
GROUP BY dp.userid, dp.firstname, dp.lastname;

-- 24. Identify delivery persons who have never delivered to a specific city.
SELECT dp.userid, dp.firstname, dp.lastname
FROM deliveryperson AS dp
WHERE dp.userid NOT IN (SELECT DISTINCT o.userid FROM "order" AS o WHERE o.city = 'SpecificCity');

-- 25. List delivery persons who have had issues with shipping orders.
SELECT dp.userid, dp.firstname, dp.lastname
FROM deliveryperson AS dp
WHERE dp.userid IN (SELECT DISTINCT o.userid FROM "order" AS o WHERE o.shippingstatus = 'Issue');

-- 26. Find the most experienced delivery person (oldest in terms of employment).
SELECT dp.userid, dp.firstname, dp.lastname, MIN(dp.dob) AS employment_start_date
FROM deliveryperson AS dp;

-- 27. Calculate the total number of orders handled by each delivery person.
SELECT dp.userid, dp.firstname, dp.lastname, COUNT(o.orderid) AS total_orders_handled
FROM deliveryperson AS dp
LEFT JOIN "order" AS o ON dp.userid = o.userid
GROUP BY dp.userid, dp.firstname, dp.lastname;

-- 28. List delivery persons who have shipped orders to multiple countries.
SELECT dp.userid, dp.firstname, dp.lastname
FROM deliveryperson AS dp
LEFT JOIN "order" AS o ON dp.userid = o.userid
GROUP BY dp.userid, dp.firstname, dp.lastname
HAVING COUNT(DISTINCT o.country) > 1;

-- 29. Find the delivery person who traveled the longest distance for an order.
SELECT dp.userid, dp.firstname, dp.lastname, MAX(o.distance) AS max_distance
FROM deliveryperson AS dp
LEFT JOIN "order" AS o ON dp.userid = o.userid
GROUP BY dp.userid, dp.firstname, dp.lastname
ORDER BY max_distance DESC
LIMIT 1;

-- 30. Identify delivery persons with the highest and lowest average order weights.
SELECT dp.userid, dp.firstname, dp.lastname, AVG(oi.subtotal) AS avg_order_weight
FROM deliveryperson AS dp
LEFT JOIN "order" AS o ON dp.userid = o.userid
LEFT JOIN orderitem AS oi ON o.orderid = oi.orderid
GROUP BY dp.userid, dp.firstname, dp.lastname
ORDER BY avg_order_weight DESC
LIMIT 1
UNION ALL
SELECT dp.userid, dp.firstname, dp.lastname, AVG(oi.subtotal) AS avg_order_weight
FROM deliveryperson AS dp
LEFT JOIN "order" AS o ON dp.userid = o.userid
LEFT JOIN orderitem AS oi ON o.orderid = oi.orderid
GROUP BY dp.userid, dp.firstname, dp.lastname
ORDER BY avg_order_weight ASC
LIMIT 1;


-- Product table queries
-- 41. List all products and their associated categories.
SELECT p.productname, p.description, p.price, c.category
FROM product AS p
LEFT JOIN categories AS c ON p.categoryid = c.categoryid;

-- 42. Find products that are often bought together in the same order.
SELECT oi1.productid AS product1, oi2.productid AS product2, COUNT(DISTINCT o1.orderid) AS order_count
FROM orderitem AS oi1
JOIN orderitem AS oi2 ON oi1.orderid = oi2.orderid AND oi1.productid < oi2.productid
JOIN "order" AS o1 ON oi1.orderid = o1.orderid
JOIN "order" AS o2 ON oi2.orderid = o2.orderid
GROUP BY oi1.productid, oi2.productid
HAVING COUNT(DISTINCT o1.orderid) > 1
ORDER BY order_count DESC;

-- 43. Calculate the total revenue from selling each product, considering discounts.
SELECT oi.productid, SUM(oi.subtotal) AS total_revenue
FROM orderitem AS oi
GROUP BY oi.productid;

-- 44. List products with descriptions containing specific keywords.
SELECT productname, description
FROM product
WHERE description ILIKE '%keyword1%' OR description ILIKE '%keyword2%';

-- 45. Find products that have received reviews with the lowest ratings.
SELECT p.productname, r.rating
FROM product AS p
LEFT JOIN reviews AS r ON p.productid = r.productid
WHERE r.rating = (SELECT MIN(rating) FROM reviews);

-- 46. Retrieve products with the highest and lowest purchase frequencies.
SELECT p.productname, COUNT(oi.orderitemid) AS purchase_frequency
FROM product AS p
LEFT JOIN orderitem AS oi ON p.productid = oi.productid
GROUP BY p.productname
ORDER BY purchase_frequency DESC
LIMIT 1
UNION ALL
SELECT p.productname, COUNT(oi.orderitemid) AS purchase_frequency
FROM product AS p
LEFT JOIN orderitem AS oi ON p.productid = oi.productid
GROUP BY p.productname
ORDER BY purchase_frequency ASC
LIMIT 1;

-- 47. List products that have been in stock for an extended period.
SELECT productname, stockqty
FROM product
WHERE stockqty > 0 AND NOW() - interval '365 days' > (SELECT MAX(orderdate) FROM "order" WHERE productid = product.productid);

-- 48. Find the top-selling product in each category.
SELECT DISTINCT ON (c.category) c.category, p.productname, SUM(oi.quantity) AS total_quantity_sold
FROM categories AS c
LEFT JOIN product AS p ON c.categoryid = p.categoryid
LEFT JOIN orderitem AS oi ON p.productid = oi.productid
GROUP BY c.category, p.productname
ORDER BY c.category, total_quantity_sold DESC;

-- 49. Calculate the total revenue from selling products on specific dates.
SELECT o.orderdate, SUM(oi.subtotal) AS total_revenue
FROM "order" AS o
LEFT JOIN orderitem AS oi ON o.orderid = oi.orderid
WHERE o.orderdate BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY o.orderdate
ORDER BY o.orderdate;

-- 50. Identify products with the highest and lowest shipping fees.
SELECT p.productname, MAX(oi.subtotal) AS highest_shipping_fee
FROM product AS p
LEFT JOIN orderitem AS oi ON p.productid = oi.productid
GROUP BY p.productname
ORDER BY highest_shipping_fee DESC
LIMIT 1
UNION ALL
SELECT p.productname, MIN(oi.subtotal) AS lowest_shipping_fee
FROM product AS p
LEFT JOIN orderitem AS oi ON p.productid = oi.productid
GROUP BY p.productname
ORDER BY lowest_shipping_fee ASC
LIMIT 1;


-- Reviews table queries
-- 51. List all reviews and their associated products and users.
SELECT r.reviewid, r.rating, r.reviewtext, r.reviewdate, u.username AS user_name, p.productname AS product_name
FROM reviews AS r
LEFT JOIN users AS u ON r.userid = u.userid
LEFT JOIN product AS p ON r.productid = p.productid;

-- 52. Find reviews with the most detailed descriptions.
SELECT r.reviewid, r.rating, r.reviewtext, u.username AS user_name, p.productname AS product_name
FROM reviews AS r
LEFT JOIN users AS u ON r.userid = u.userid
LEFT JOIN product AS p ON r.productid = p.productid
ORDER BY LENGTH(r.reviewtext) DESC
LIMIT 1;

-- 53. Calculate the average review rating for each product.
SELECT r.productid, AVG(r.rating) AS average_rating
FROM reviews AS r
GROUP BY r.productid;

-- 54. List reviews with the same text content.
SELECT r1.reviewid, r1.rating, r1.reviewtext, r1.reviewdate, u1.username AS user1, r2.reviewid AS duplicate_review_id, u2.username AS user2
FROM reviews AS r1
JOIN reviews AS r2 ON r1.reviewtext = r2.reviewtext AND r1.reviewid <> r2.reviewid
LEFT JOIN users AS u1 ON r1.userid = u1.userid
LEFT JOIN users AS u2 ON r2.userid = u2.userid;

-- 55. Find reviews by users who have never placed an order.
SELECT r.reviewid, r.rating, r.reviewtext, r.reviewdate, u.username AS user_name
FROM reviews AS r
LEFT JOIN users AS u ON r.userid = u.userid
WHERE r.userid NOT IN (SELECT userid FROM "order");

-- 56. Retrieve reviews for products that have been discontinued.
SELECT r.reviewid, r.rating, r.reviewtext, r.reviewdate, p.productname AS product_name
FROM reviews AS r
LEFT JOIN product AS p ON r.productid = p.productid
WHERE p.stockqty = 0;

-- 57. List reviews posted on specific dates with ratings above 3.
SELECT r.reviewid, r.rating, r.reviewtext, r.reviewdate, p.productname AS product_name
FROM reviews AS r
LEFT JOIN product AS p ON r.productid = p.productid
WHERE r.rating > 3 AND r.reviewdate BETWEEN '2023-01-01' AND '2023-12-31';

-- 58. Calculate the average time taken by users to post a review after purchase.
SELECT u.username AS user_name, AVG(EXTRACT(EPOCH FROM (r.reviewdate - o.orderdate)) / 3600) AS avg_time_in_hours
FROM users AS u
LEFT JOIN "order" AS o ON u.userid = o.userid
LEFT JOIN reviews AS r ON u.userid = r.userid AND o.orderid = r.orderid
GROUP BY u.username
ORDER BY avg_time_in_hours;

-- 59. Find reviews for products in a specific category with the highest ratings.
SELECT r.reviewid, r.rating, r.reviewtext, r.reviewdate, p.productname AS product_name, c.category AS product_category
FROM reviews AS r
LEFT JOIN product AS p ON r.productid = p.productid
LEFT JOIN categories AS c ON p.categoryid = c.categoryid
WHERE c.category = 'Specific Category' AND r.rating = (SELECT MAX(rating) FROM reviews WHERE productid = r.productid);

-- 60. Identify users who have reviewed the most products in a single day.
SELECT u.userid, u.username AS user_name, COUNT(DISTINCT r.productid) AS reviewed_products_count, r.reviewdate::DATE AS review_day
FROM users AS u
LEFT JOIN reviews AS r ON u.userid = r.userid
GROUP BY u.userid, review_day
HAVING COUNT(DISTINCT r.productid) = (SELECT MAX(reviewed_products_count) FROM (SELECT COUNT(DISTINCT r.productid) AS reviewed_products_count, r.userid, r.reviewdate::DATE AS review_day FROM reviews AS r GROUP BY r.userid, review_day) AS max_reviews);

-- Wallet table queries
-- 71. List all wallets and their associated users.
SELECT w.walletid, w.balance, u.username AS user_name
FROM wallet AS w
LEFT JOIN users AS u ON w.userid = u.userid;

-- 72. Calculate the total wallet balance for each user.
SELECT w.userid, u.username AS user_name, SUM(w.balance) AS total_balance
FROM wallet AS w
LEFT JOIN users AS u ON w.userid = u.userid
GROUP BY w.userid, user_name;

-- 73. Find users who have had recent wallet transactions.
SELECT w.userid, u.username AS user_name, MAX(w.transactiondate) AS last_transaction_date
FROM wallet AS w
LEFT JOIN users AS u ON w.userid = u.userid
GROUP BY w.userid, user_name
HAVING MAX(w.transactiondate) >= NOW() - INTERVAL '7 days';

-- 74. List wallets with negative balances.
SELECT w.walletid, w.balance
FROM wallet AS w
WHERE w.balance < 0;

-- 75. Retrieve wallets that haven't had any transactions in the last year.
SELECT w.walletid, w.balance
FROM wallet AS w
WHERE w.transactiondate < NOW() - INTERVAL '1 year';

-- 76. Calculate the average transaction amount for each user's wallet.
SELECT w.userid, u.username AS user_name, AVG(w.balance) AS avg_transaction_amount
FROM wallet AS w
LEFT JOIN users AS u ON w.userid = u.userid
GROUP BY w.userid, user_name;

-- 77. Find users with the highest and lowest lifetime spending.
SELECT w.userid, u.username AS user_name, SUM(w.balance) AS total_spending
FROM wallet AS w
LEFT JOIN users AS u ON w.userid = u.userid
GROUP BY w.userid, user_name
ORDER BY total_spending DESC
LIMIT 1
UNION ALL
SELECT w.userid, u.username AS user_name, SUM(w.balance) AS total_spending
FROM wallet AS w
LEFT JOIN users AS u ON w.userid = u.userid
GROUP BY w.userid, user_name
ORDER BY total_spending ASC
LIMIT 1;

-- 78. List wallets with unusual transaction patterns (e.g., consecutive large withdrawals).
SELECT w.walletid, w.balance, w.transactiondate
FROM wallet AS w
WHERE EXISTS (
    SELECT 1
    FROM wallet AS w2
    WHERE w.walletid = w2.walletid
      AND w.balance < 0
      AND w2.transactiondate >= w.transactiondate - INTERVAL '1 day'
);

-- 79. Calculate the average time between transactions for each wallet.
SELECT w.walletid, AVG(EXTRACT(EPOCH FROM (w.transactiondate - w2.transactiondate)) / 3600) AS avg_time_between_transactions
FROM wallet AS w
LEFT JOIN wallet AS w2 ON w.walletid = w2.walletid
GROUP BY w.walletid;

-- 80. Identify users with inconsistent wallet balances across multiple transactions.
SELECT w.userid, u.username AS user_name, w.walletid, w.balance
FROM wallet AS w
LEFT JOIN users AS u ON w.userid = u.userid
WHERE NOT EXISTS (
    SELECT 1
    FROM wallet AS w2
    WHERE w.userid = w2.userid
      AND w.balance = w2.balance
      AND w.walletid <> w2.walletid
);


-- Paymentsmethod table queries
-- 81. List all payment methods and their associated users.
SELECT pm.paymentmethodid, pm.paymenttype, u.username AS user_name
FROM paymentsmethod AS pm
LEFT JOIN users AS u ON pm.userid = u.userid;

-- 82. Find payment methods that have been used for high-value orders.
SELECT pm.paymentmethodid, pm.paymenttype, o.totalamt
FROM paymentsmethod AS pm
INNER JOIN "order" AS o ON pm.paymentmethodid = o.paymentmethodid
WHERE o.totalamt >= 1000;

-- 83. Calculate the total transaction amount for each payment method.
SELECT pm.paymentmethodid, pm.paymenttype, SUM(o.totalamt) AS total_transaction_amount
FROM paymentsmethod AS pm
LEFT JOIN "order" AS o ON pm.paymentmethodid = o.paymentmethodid
GROUP BY pm.paymentmethodid, pm.paymenttype;

-- 84. List payment methods used by users with the highest wallet balances.
SELECT pm.paymentmethodid, pm.paymenttype, u.username AS user_name, w.balance
FROM paymentsmethod AS pm
INNER JOIN users AS u ON pm.userid = u.userid
LEFT JOIN wallet AS w ON u.userid = w.userid
WHERE w.balance = (SELECT MAX(balance) FROM wallet);

-- 85. Find payment methods with the most frequent usage.
SELECT pm.paymentmethodid, pm.paymenttype, COUNT(o.orderid) AS order_count
FROM paymentsmethod AS pm
LEFT JOIN "order" AS o ON pm.paymentmethodid = o.paymentmethodid
GROUP BY pm.paymentmethodid, pm.paymenttype
ORDER BY order_count DESC
LIMIT 1;

-- 86. Retrieve payment methods with transactions on specific dates.
SELECT pm.paymentmethodid, pm.paymenttype, o.orderdate
FROM paymentsmethod AS pm
INNER JOIN "order" AS o ON pm.paymentmethodid = o.paymentmethodid
WHERE o.orderdate BETWEEN '2023-01-01' AND '2023-01-31';

-- 87. List payment methods with incomplete or missing information.
SELECT pm.paymentmethodid, pm.paymenttype
FROM paymentsmethod AS pm
WHERE pm.paymenttype IS NULL OR pm.paymenttype = '';

-- 88. Calculate the average transaction amount for each user's payment methods.
SELECT u.userid, u.username AS user_name, pm.paymentmethodid, pm.paymenttype, AVG(o.totalamt) AS avg_transaction_amount
FROM users AS u
LEFT JOIN paymentsmethod AS pm ON u.userid = pm.userid
LEFT JOIN "order" AS o ON pm.paymentmethodid = o.paymentmethodid
GROUP BY u.userid, user_name, pm.paymentmethodid, pm.paymenttype;

-- 89. Find users who have used different payment methods for multiple orders.
SELECT u.userid, u.username AS user_name, COUNT(DISTINCT pm.paymentmethodid) AS distinct_payment_methods_count, COUNT(DISTINCT o.orderid) AS distinct_orders_count
FROM users AS u
LEFT JOIN paymentsmethod AS pm ON u.userid = pm.userid
LEFT JOIN "order" AS o ON u.userid = o.userid
GROUP BY u.userid, user_name
HAVING distinct_payment_methods_count > 1 AND distinct_orders_count > 1;

-- 90. Identify payment methods that have never been used in combination with specific shipping methods.
SELECT pm.paymentmethodid, pm.paymenttype, sm.shippingmethodid, sm.shippingtype
FROM paymentsmethod AS pm
CROSS JOIN shippingmethod AS sm
WHERE NOT EXISTS (
    SELECT 1
    FROM "order" AS o
    WHERE pm.paymentmethodid = o.paymentmethodid
      AND sm.shippingmethodid = o.shippingmethodid
);


-- Order table queries
-- 91. List all orders and their associated users, products, and deliverypersons.
SELECT o.orderid, u.username AS user_name, p.productname, d.username AS deliveryperson_name
FROM "order" AS o
INNER JOIN users AS u ON o.userid = u.userid
INNER JOIN orderitem AS oi ON o.orderid = oi.orderid
INNER JOIN product AS p ON oi.productid = p.productid
INNER JOIN deliveryperson AS d ON o.shippingaddressid = d.userid;

-- 92. Find orders with high shipping fees relative to the order amount.
SELECT o.orderid, o.totalamt, o.shippingaddressid, o.paymentmethodid
FROM "order" AS o
WHERE o.totalamt / o.shippingaddressid > 5;

-- 93. Calculate the total revenue from orders placed by each user.
SELECT u.userid, u.username AS user_name, SUM(o.totalamt) AS total_revenue
FROM users AS u
LEFT JOIN "order" AS o ON u.userid = o.userid
GROUP BY u.userid, user_name;

-- 94. List orders with a specific payment method and shipping address combination.
SELECT o.orderid, o.orderdate, o.paymentmethodid, o.shippingaddressid
FROM "order" AS o
WHERE o.paymentmethodid = 1 AND o.shippingaddressid = 2;

-- 95. Find orders that contain products from specific categories.
SELECT o.orderid, o.orderdate, o.totalamt, p.productname, c.category
FROM "order" AS o
INNER JOIN orderitem AS oi ON o.orderid = oi.orderid
INNER JOIN product AS p ON oi.productid = p.productid
INNER JOIN categories AS c ON p.categoryid = c.categoryid
WHERE c.category IN ('Electronics', 'Clothing');

-- 96. Retrieve orders with the highest and lowest order item counts.
SELECT o.orderid, COUNT(oi.orderitemid) AS order_item_count
FROM "order" AS o
LEFT JOIN orderitem AS oi ON o.orderid = oi.orderid
GROUP BY o.orderid
ORDER BY order_item_count DESC
LIMIT 1

UNION

SELECT o.orderid, COUNT(oi.orderitemid) AS order_item_count
FROM "order" AS o
LEFT JOIN orderitem AS oi ON o.orderid = oi.orderid
GROUP BY o.orderid
ORDER BY order_item_count ASC
LIMIT 1;

-- 97. List orders with unusual time gaps between order placement and shipping.
SELECT o.orderid, o.orderdate, o.shipmentdate
FROM "order" AS o
WHERE DATE_PART('day', o.shipmentdate - o.orderdate) > 7;

-- 98. Calculate the average shipping fee for orders shipped to each city.
SELECT a.city, AVG(o.shippingaddressid) AS avg_shipping_fee
FROM addresses AS a
INNER JOIN "order" AS o ON a.addressid = o.shippingaddressid
GROUP BY a.city;

-- 99. Find orders with specific coupon codes applied.
SELECT o.orderid, o.orderdate, o.totalamt, c.couponcode
FROM "order" AS o
INNER JOIN coupon AS c ON o.orderid = c.orderid
WHERE c.couponcode IN (123, 456);

-- 100. Identify orders that have had payment method changes.
SELECT o.orderid, o.orderdate, o.paymentmethodid
FROM "order" AS o
WHERE o.paymentmethodid <> (SELECT DISTINCT(paymentmethodid) FROM paymentsmethod)

