create or replace procedure currency_calc(
	start_cur bpchar(3),
	end_cur bpchar(3),
	amount float,
	date timestamp
)
language plpgsql as $$
declare
    rate numeric;
    selected_cur bpchar(3);
    result_cur float;
begin
    if (start_cur != 'USD') and (end_cur != 'USD') then
        raise exception 'wrong input currency';
    end if;

    if (start_cur = 'USD') then
        selected_cur := end_cur;
    else
        selected_cur := start_cur;
    end if;

    select averagerate
        into rate
        from sales.currencyrate r
        where r.tocurrencycode = selected_cur
          and r.currencyratedate = date;

    if (rate is null) then
        raise exception 'no rate found';
    end if;

    if (start_cur != 'USD') then
        rate := 1/rate;
    end if;
    raise notice 'rate = %', rate;
    result_cur = amount * rate;

    raise notice 'Converted % % to % %', amount, start_cur, result_cur, end_cur;
end
$$;

call currency_calc('USD', 'EUR', 10, '2012-06-29 00:00:00');
call currency_calc('USD', 'USD', 10, '2077-01-01 00:00:00');
call currency_calc('EUR', 'USD', 10, '2012-06-23 00:00:00');
call currency_calc('123', 'XXX', 10, '2012-03-13 00:00:00');
call currency_calc('123', 'USD', 10, '2012-04-21 00:00:00');
