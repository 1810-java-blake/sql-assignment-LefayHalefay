-- Part I – Working with an existing database
-- 1.0	Setting up Oracle Chinook
-- In this section you will begin the process of working with the Oracle Chinook database
-- Task – Open the Chinook_Oracle.sql file and execute the scripts within.
-- 2.0 SQL Queries
-- In this section you will be performing various queries against the Oracle Chinook database.
-- 2.1 SELECT
-- Task – Select all records from the Employee table.
   set schema 'chinook'; -- We must it to this at the begning of our queires.
   SELECT * FROM employee;
-- Task – Select all records from the Employee table where last name is King.
   SELECT * FROM employee where lastname = 'King';
-- Task – Select all records from the Employee table where first name is Andrew and REPORTSTO is NULL.
   SELECT * FROM employee where firstname = 'Andrew' AND REPORTSTO  isNULL;

-- 2.2 ORDER BY
-- Task – Select all albums in Album table and sort result set in descending order by title.
   SELECT * FROM album 
   ORDER BY title 
   DESC;
-- Task – Select first name from Customer and sort result set in ascending order by city
   SELECT firstname FROM customer
   ORDER BY city
   asc;
-- 2.3 INSERT INTO
-- Task – Insert two new records into Genre table
   INSERT INTO genre (genreid, name) VALUES (26,'Trap'),
   (27,'world');
-- Task – Insert two new records into Employee table
   INSERT INTO EMPLOYEE(employeeid, lastname,firstname,title,reportsto,birthdate,hiredate,address,city,state,country,postalcode,phone,fax,email)
   values (9,'Yosief','Minasie','Software Engineer',8,'1992-11-19 00:00:00', '2018-10-15 00:00:00','2019 Court White DR.', 'Garland','TX','US','75098',
      '+1 (214) 999-9999', '+1 (214) 999-9999','minasieY@rev.edu');

   INSERT INTO EMPLOYEE(employeeid, lastname,firstname,title,reportsto,birthdate,hiredate,address,city,state,country,postalcode,phone,fax,email)
   values (10,'Efrem','Hagos','Disphacher',9,'1994-11-19 00:00:00', '2018-10-25 00:00:00','9019 Crest White DR.', 'Garland','TX','US','75068',
      '+1 (214) 999-9999', '+1 (214) 999-9999','efeeeY@rev.edu');

-- Task – Insert two new records into Customer table
   INSERT INTO CUSTOMER(customerid, firstname, lastname, company, address, city, state, country, postalcode,phone, fax, email, supportrepid)
   VALUES (60,'Minasie','Yosief','Revature LLC.','1700 Amasra St.', 'Reston', 'VA','US','10001','+1(214) 999-9999','','minasiey@reva@edu',9);

   INSERT INTO CUSTOMER(customerid, firstname, lastname, company, address, city, state, country, postalcode,phone, fax, email, supportrepid)
   VALUES (61,'Efrem','Hagos',null,'1700 Amasra St.', 'Reston', 'VA','US','10001','+1(214) 000-9999',null,'efeeeeY@reva@edu',10);

-- 2.4 UPDATE
-- Task – Update Aaron Mitchell in Customer table to Robert Walter
   Update CUSTOMER 
   SET firstname = 'Robert', lastname = 'Walter'
   WHERE firstname = 'Aaron';

-- Task – Update name of artist in the Artist table “Creedence Clearwater Revival” to “CCR”
   Update artist
   SET name = 'CCR'
   WHERE name = 'Creedence Clearwater Revival';

-- 2.5 LIKE
-- Task – Select all invoices with a billing address like “T%”
   SELECT * FROM invoice 
   WHERE billingaddress LIKE 'T%';

-- 2.6 BETWEEN
-- Task – Select all invoices that have a total between 15 and 50
   SELECT * FROM invoice 
   WHERE total BETWEEN '15' AND '50';
-- Task – Select all employees hired between 1st of June 2003 and 1st of March 2004
   SELECT * FROM EMPLOYEE WHERE
   hiredate BETWEEN '2003-06-01 00:00:00' AND '2004-03-01 00:00:00';
-- 2.7 DELETE
-- Task – Delete a record in Customer table where the name is Robert Walter (There may be constraints that rely on this, find out how to resolve them).

-- 3.0 
SQL Functions
-- In this section you will be using the Oracle system functions, as well as your own functions, to perform various actions against the database
-- 3.1 System Defined Functions
-- Task – Create a function that returns the current time.
      CREATE OR REPLACE FUNCTION myTimeWorthy()
      RETURNS  TIME  AS $$
      BEGIN
         RETURN CURRENT_TIME;
      END
      $$ Language plpgsql;
-- Task – create a function that returns the length of a mediatype from the mediatype table
      CREATE OR REPLACE FUNCTION LenthOfMediaType()
      RETURNS INTEGER AS $$
            BEGIN 
		RETURN 
		(SELECT COUNT(mediatypeid)
		FROM mediatype);
      END
      $$ LANGUAGE plpgsql;
-- 3.2 System Defined Aggregate Functions
-- Task – Create a function that returns the average total of all invoices
      CREATE OR REPLACE FUNCTION myAverage()
      RETURNS DECIMAL AS $$
            BEGIN
            RETURN
            (SELECT 
                  (SELECT SUM(total) FROM invoice)
                  / (SELECT COUNT(invoiceid) FROM invoice)
            );
            END
      $$ LANGUAGE plpgsql;
-- Task – Create a function that returns the most expensive track
      CREATE OR REPLACE FUNCTION expensiveTrack() 
      RETURNS DECIMAL AS $$ 
      BEGIN
      RETURN
            (SELECT MAX(unitprice) 
            FROM track
            );
      END;
      $$ LANGUAGE plpgsql;
-- 3.3 User Defined Scalar Functions
-- Task – Create a function that returns the average price of invoiceline items in the invoiceline table
      CREATE OR REPLACE FUNCTION myAverageInv()
      RETURNS DECIMAL AS $$
 		BEGIN
 		RETURN
 		(SELECT 
 			  (SELECT SUM(unitprice) FROM invoiceline)
 			  / (SELECT COUNT(invoicelineid) FROM invoiceline)
 		);
 		END
      $$ LANGUAGE plpgsql;
-- 3.4 User Defined Table Valued Functions
-- Task – Create a function that returns all employees who are born after 1968.

      CREATE OR REPLACE function bornAfterEmployeeFunc()
      RETURNS TABLE (
      firstnameE VARCHAR,
      lastnameE VARCHAR
      --dateOfBirth DATE 
      ) AS $$
      BEGIN
            RETURN QUERY
      SELECT firstname, lastname from employee WHERE birthdate >= '1968-01-01 00:00:00';
      END; $$

      language plpgsql;
-- 4.0 Stored Procedures
-- In this section you will be creating and executing stored procedures.
-- You will be creating various types of stored procedures that take input and output parameters.

-- 4.1 Basic Stored Procedure
-- Task – Create a stored procedure that selects the first and last names of all the employees.
      CREATE OR REPLACE FUNCTION emoloyeeNames() RETURNS refcursor AS $$
      DECLARE 
      ref refcursor;
      BEGIN 
            OPEN ref FOR SELECT lastname, firstname from employee;
            return ref;
      END;
      $$ Language plpgsql;

-- 4.2 Stored Procedure Input Parameters
-- Task – Create a stored procedure that updates the personal information of an employee.

-- Task – Create a stored procedure that returns the managers of an employee.
-- 4.3 Stored Procedure Output Parameters
-- Task – Create a stored procedure that returns the name and company of a customer.

-- 5.0 Transactions
-- In this section you will be working with transactions. Transactions are usually nested within a stored procedure. You will also be working with handling errors in your SQL.
-- Task – Create a transaction that given a invoiceId will delete that invoice (There may be constraints that rely on this, find out how to resolve them).

-- Task – Create a transaction nested within a stored procedure that inserts a new record in the Customer table

-- 6.0 Triggers
-- In this section you will create various kinds of triggers that work when certain DML statements are executed on a table.
-- 6.1 AFTER/FOR
-- Task - Create an after insert trigger on the employee table fired after a new record is inserted into the table.
     
      --Audit Table
      CREATE TABLE employee_audit(
	new_employee_id SERIAL PRIMARY KEY, 
 	last_name TEXT,
	first_name TEXT
       );

      CREATE OR REPLACE FUNCTION emp_audit_trig_func()
      RETURNS TRIGGER AS $$
      BEGIN
      IF(TG_OP = 'INSERT') THEN
            INSERT INTO employee_audit (
                  new_employee_id,
                  last_name,
                  first_name
            ) VALUES (
                  NEW.employeid,
                  NEW.lastname,
                  NEW.firstname
      );
      END IF;
      RETURN NEW;
      END;
      $$ LANGUAGE plpgsql;

      CREATE TRIGGER employees_audit_trig
      AFTER INSERT ON employee
      FOR EACH ROW
      EXECUTE PROCEDURE emp_audit_trig_func();
 
-- Task – Create an after update trigger on the album table that fires after a row is inserted in the table
      CREATE TABLE album_audit(
            album_id SERIAL PRIMARY KEY,
            old_album_id INTEGER,
            old_album_title TEXT,
            new_album_id INTEGER,
            new_album_title TEXT
    );
    CREATE OR REPLACE FUNCTION album_audit_trig_func()
	RETURNS TRIGGER AS $$
	BEGIN
 	IF(TG_OP = 'UPDATE') THEN
 		INSERT INTO album_audit
 		(	old_album_id, 
		 	old_album_title,
		 	new_album_id,
		 	new_album_name
		) VALUES(
			OLD.albumid,
			OLD.title,
			NEW.new_album_id,
			NEW.new_album_name
		);
		END IF;
	RETURN NEW;
	END;
	$$ LANGUAGE plpgsql;
	
	CREATE TRIGGER album_audit_trig
	AFTER DELETE ON album
	FOR EACH ROW
	EXECUTE PROCEDURE album_audit_trig_func();

-- Task – Create an after delete trigger on the customer table that fires after a row is deleted from the table.

-- 6.2 Before
-- Task – Create a before trigger that restricts the deletion of any invoice that is priced over 50 dollars.
-- 7.0 JOINS
-- In this section you will be working with combing various tables through the use of joins. 
-- You will work with outer, inner, right, left, cross, and self joins.
-- 7.1 INNER
-- Task – Create an inner join that joins customers and orders and specifies the name of the customer and the invoiceId.
      SELECT * FROM customer
      INNER JOIN invoice
      ON (customer.customerid = invoice.customerid);
-- 7.2 OUTER
-- Task – Create an outer join that joins the customer and invoice table, specifying the CustomerId, firstname, lastname, invoiceId, and total.
      SELECT CUSTOMER.customerid, CUSTOMER.firstname, CUSTOMER.lastname, invoice.invoiceid, invoice.total 
      FROM CUSTOMER 
      FULL OUTER JOIN invoice ON CUSTOMER.customerid = invoice.customerid;
-- 7.3 RIGHT
-- Task – Create a right join that joins album and artist specifying artist name and title.
      SELECT  artist.name, album.title
      FROM artist
      RIGHT OUTER JOIN album ON artist.artistid = album.artistid;
-- 7.4 CROSS
-- Task – Create a cross join that joins album and artist and sorts by artist name in ascending order.
-- 7.5 SELF
-- Task – Perform a self-join on the employee table, joining on the reportsto column.








