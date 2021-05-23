DO $$
    DECLARE
        avg_emp_sal NUMERIC(10,2);
        emp_cur cursor for
            SELECT rate, firstname, lastname, jobtitle FROM humanresources.employee
                INNER JOIN humanresources.employeepayhistory e ON employee.businessentityid = e.businessentityid
                INNER JOIN person.person ON employee.businessentityid = person.businessentityid;

    BEGIN
        SELECT avg(rate)
        FROM humanresources.employee
            INNER JOIN humanresources.employeepayhistory
            on employee.businessentityid = employeepayhistory.businessentityid into avg_emp_sal;

        raise notice 'Average rate: %', avg_emp_sal;

        FOR emp IN emp_cur LOOP
            IF emp.rate < avg_emp_sal THEN
                RAISE NOTICE '%', emp;
            END IF;
        END LOOP;
    END;
$$;