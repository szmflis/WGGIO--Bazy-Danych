DROP PROCEDURE writefibonacci(integer);
DROP FUNCTION Fib(integer);

create function Fib(upper int) returns void as
$$
declare
    current integer := 0;
    next    integer := 1;
    result  integer := 0;
    iter    integer := 0;

begin
    while iter < upper
        loop
            raise notice '%', current;
            result := current + next;
            current := next;
            next := result;
            iter := iter + 1;
        end loop;
end
$$ language plpgsql;

create procedure WriteFibonacci(upper int)
    language SQL
as
$$
select Fib(20);
$$;

CALL WriteFibonacci(20);
