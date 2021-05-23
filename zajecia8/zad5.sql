-- Utwórz procedurę składowaną,
-- która jako parametry wejściowe przyjmujedwie liczby,
-- num1i num2, a zwraca wynik ich dzielenia.
-- Ponadto wartość num1 powinna zawsze być większa niż wartość num2.
-- Jeżeli wartość num1jest mniejsza niż num2, wygeneruj komunikat o błędzie
-- „Niewłaściwie zdefiniowałeś dane wejściowe”.

CREATE OR REPLACE PROCEDURE divide_two_nums(num1 float, num2 float)
LANGUAGE plpgsql
as
$$
DECLARE
    result float;
BEGIN
    IF num2 > num1 THEN
        RAISE 'Niewłaściwie zdefiniowałeś dane wejściowe';
    ELSE
        result :=  num1/num2;
        RAISE NOTICE 'Wynik dzielenia %', result;
    END IF;
END
$$;

CALL divide_two_nums(6,3);
CALL divide_two_nums(5,2);
CALL divide_two_nums(1,3);