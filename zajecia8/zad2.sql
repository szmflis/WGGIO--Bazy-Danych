DROP FUNCTION get_due_of_order(orderid int);
create or replace function get_due_of_order(orderid int)
returns DATE
language plpgsql
as
$$
declare
   order_date DATE;
begin
    SELECT duedate
        INTO order_date
        FROM purchasing.purchaseorderdetail
        WHERE purchaseorderdetailid = orderid;

   return order_date;
end;
$$;


DO $$
DECLARE
    order_date DATE;
BEGIN
    SELECT * FROM "get_due_of_order"(3) into order_date;
    RAISE NOTICE '%', order_date;
END
$$;