-- Cross Join
/*1. Suppose every vendor in the `vendor_inventory` table had 5 of each of their products to sell to **every** 
customer on record. How much money would each vendor make per product? 
Show this by vendor_name and product name, rather than using the IDs.

HINT: Be sure you select only relevant columns and rows. 
Remember, CROSS JOIN will explode your table rows, so CROSS JOIN should likely be a subquery. 
Think a bit about the row counts: how many distinct vendors, product names are there (x)?
How many customers are there (y). 
Before your final group by you should have the product of those two queries (x*y).  */

-- Combining vendor, product and vendor_inventory table to find out vendor name, product name
-- Selecting first 5 products offered by a vendor for sale
-- Creating a temporary table to store these information
DROP TABLE IF EXISTS temp.vendor_products;
CREATE TEMP TABLE temp.vendor_products AS
SELECT  *
FROM ( 
	SELECT vi.market_date, vi.vendor_id, v.vendor_name, vi.product_id, p.product_name, vi.original_price,
    ROW_NUMBER() OVER (PARTITION BY vi.vendor_id ORDER BY vi.product_id) AS row_num
    FROM vendor_inventory vi
	JOIN vendor v ON vi.vendor_id = v.vendor_id
	JOIN product p ON vi.product_id = p.product_id
)
WHERE row_num <= 5;

-- SELECT * from vendor_products;

-- Finding out total distinct customer records
-- Storing this information in another temporary table
DROP TABLE IF EXISTS temp.customer_count;
CREATE TEMP TABLE temp.customer_count AS
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM customer;

-- SELECT * from customer_count;

-- Using cross join between 2 temporary tables to find out total money a vendor could make on that specific product if they sell it to all the customers on a specific market date.
SELECT vp.market_date, vp.vendor_name, vp.product_name, (cc.total_customers * vp.original_price) AS total_revenue_per_product
FROM vendor_products vp
CROSS JOIN customer_count cc;


-- INSERT
/*1.  Create a new table "product_units". 
This table will contain only products where the `product_qty_type = 'unit'`. 
It should use all of the columns from the product table, as well as a new column for the `CURRENT_TIMESTAMP`.  
Name the timestamp column `snapshot_timestamp`. */

DROP TABLE IF EXISTS temp.product_units;
CREATE TEMP TABLE temp.product_units AS
SELECT *, CURRENT_TIMESTAMP AS snapshot_timestamp
FROM product AS p
WHERE p.product_qty_type = 'unit'
ORDER BY p.product_id;

-- SELECT * FROM temp.product_units;


/*2. Using `INSERT`, add a new row to the product_units table (with an updated timestamp). 
This can be any product you desire (e.g. add another record for Apple Pie). */

INSERT INTO temp.product_units (product_id, product_name, product_size, product_category_id, product_qty_type, snapshot_timestamp)
VALUES (
    (SELECT IFNULL(MAX(product_id), 0) + 1 FROM temp.product_units),  'Apple Pie',  '8"', 3, 'unit', CURRENT_TIMESTAMP
);

-- SELECT * FROM temp.product_units;

-- DELETE
/* 1. Delete the older record for the whatever product you added. 

HINT: If you don't specify a WHERE clause, you are going to have a bad time.*/

DELETE FROM temp.product_units
WHERE product_id = (
    SELECT IFNULL(MAX(product_id), 0) FROM temp.product_units
    ORDER BY snapshot_timestamp ASC
    LIMIT 1
);

-- SELECT * FROM temp.product_units;


-- UPDATE
/* 1.We want to add the current_quantity to the product_units table. 
First, add a new column, current_quantity to the table using the following syntax.

ALTER TABLE product_units
ADD current_quantity INT;

Then, using UPDATE, change the current_quantity equal to the last quantity value from the vendor_inventory details.

HINT: This one is pretty hard. 
First, determine how to get the "last" quantity per product. 
Second, coalesce null values to 0 (if you don't have null values, figure out how to rearrange your query so you do.) 
Third, SET current_quantity = (...your select statement...), remembering that WHERE can only accommodate one column. 
Finally, make sure you have a WHERE statement to update the right row, 
	you'll need to use product_units.product_id to refer to the correct row within the product_units table. 
When you have all of these components, you can run the update statement. */

ALTER TABLE temp.product_units
ADD current_quantity INT;

UPDATE temp.product_units
SET current_quantity = (
    SELECT COALESCE((SELECT vi.quantity FROM vendor_inventory vi WHERE vi.product_id = product_units.product_id ORDER BY vi.market_date DESC LIMIT 1), 0)
);

-- SELECT * FROM temp.product_units;