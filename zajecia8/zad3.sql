-- 3.Utwórz procedurę składowaną, która jako parametr przyjmuję nazwę produktu,
-- a jako rezultat wyświetla jego identyfikator, numer i dostępność

create or replace procedure productInfo (productName varchar)
language plpgsql as $$
declare
    prod_id int;
    prod_num varchar(25);
    prod_quan int;
begin
    SELECT i.productid, productnumber, quantity
        INTO prod_id, prod_num, prod_quan
        FROM production.product p
        INNER JOIN production.productinventory i
            ON p.productid = i.productid
        WHERE name = productName;

    RAISE NOTICE '% % %', prod_id, prod_num, prod_quan;
end; $$;

CALL productInfo('Adjustable Race');