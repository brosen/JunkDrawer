DECLARE @idoc int, @doc varchar(1000);
SET @doc ='
<ROOT>
<Customer CustomerID="VINET" ContactName="Paul Henriot">
   <Order CustomerID="VINET" EmployeeID="5" OrderDate="1996-07-04T00:00:00">
      <OrderDetail OrderID="10248" ProductID="11" Quantity="12"/>
      <OrderDetail OrderID="10248" ProductID="42" Quantity="10"/>
   </Order>
</Customer>
<Customer CustomerID="LILAS" ContactName="Carlos Gonzlez">
   <Order CustomerID="LILAS" EmployeeID="3" OrderDate="1996-08-16T00:00:00">
      <OrderDetail OrderID="10283" ProductID="72" Quantity="3"/>
   </Order>
</Customer>
</ROOT>';
--Create an internal representation of the XML document.
EXEC sp_xml_preparedocument @idoc OUTPUT, @doc;

-- Execute a SELECT statement that uses the OPENXML rowset provider.
SELECT    *
FROM       OPENXML (@idoc, '/ROOT/Customer',1)
            WITH (CustomerID  varchar(10),
                  ContactName varchar(20));
                          
SELECT    *
FROM       OPENXML (@idoc, '/ROOT/Customer/Order/OrderDetail',1)
            WITH (OrderID  int,
                  ProductID int,
				Quantity int);
                  
                  
EXEC sp_xml_removedocument @idoc     