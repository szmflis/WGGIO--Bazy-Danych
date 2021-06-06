-- 4.Utwórz funkcję, która zwraca numer karty kredytowej dla konkretnego zamówienia.

DROP FUNCTION get_card_num_from_order(orderid int);
CREATE OR REPLACE FUNCTION get_card_num_from_order(orderid int)
RETURNS varchar(60)
LANGUAGE plpgsql
as $$
DECLARE
    card_num varchar(60);
    card_id int;
BEGIN
    SELECT creditcardid
    INTO card_id
    FROM sales.salesorderheader s
    INNER JOIN sales.customer c ON s.customerid = c.customerid
    WHERE s.salesorderid = orderid;

    SELECT *
    INTO card_num
    FROM sales.creditcard c
    WHERE c.creditcardid = card_id;

    RAISE NOTICE '%', card_num;

    return card_num;
END
$$;

DO $$
DECLARE
    cardnum varchar(60);
BEGIN
    SELECT get_card_num_from_order(44134) into cardnum;
    RAISE NOTICE 'Card number: %', cardnum;
END;
$$;
