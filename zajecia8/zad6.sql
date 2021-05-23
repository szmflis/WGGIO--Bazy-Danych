DROP FUNCTION get_person_data(national_id_num varchar);

CREATE OR REPLACE FUNCTION get_person_data(national_id_num varchar(15))
RETURNS TABLE (
    _jobtitle varchar(50),
    _vacationdays int,
    _sickleavedays int
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
        SELECT
           jobtitle as _jobtitle,
           vacationhours / 8 AS _vacationdays,
           sickleavehours / 8 as _sickleavedays
        FROM humanresources.employee e
        WHERE nationalidnumber = national_id_num;
END
$$;

SELECT * FROM get_person_data('245797967');
SELECT * FROM get_person_data('509647174');
SELECT * FROM get_person_data('811994146');
SELECT * FROM get_person_data('56920285');
SELECT * FROM get_person_data('243322160');