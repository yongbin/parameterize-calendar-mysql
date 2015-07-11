SELECT
        woy                                                     AS 'week'
        ,MAX(CASE WHEN `dow` = '2' THEN `dom_f` END)            AS 'Mo'
        ,MAX(CASE WHEN `dow` = '3' THEN `dom_f` END)            AS 'Tu'
        ,MAX(CASE WHEN `dow` = '4' THEN `dom_f` END)            AS 'We'
        ,MAX(CASE WHEN `dow` = '5' THEN `dom_f` END)            AS 'Th'
        ,MAX(CASE WHEN `dow` = '6' THEN `dom_f` END)            AS 'Fr'
        ,MAX(CASE WHEN `dow` = '7' THEN `dom_f` END)            AS 'Sa'
        ,MAX(CASE WHEN `dow` = '1' THEN `dom_f` END)            AS 'Su'
FROM
(
    SELECT
            *
    FROM
    (
        SELECT
                `date_string`
                ,DAYOFMONTH(`date_string`)             AS dom           -- day of month
                ,DAYOFWEEK(`date_string`)              AS dow           -- day of week( 1 - sunday, 2 - monday ... )
                ,WEEKOFYEAR(`date_string`)             AS woy           -- week of year
                ,lpad(DAYOFMONTH(`date_string`),2,'0') AS dom_f         -- left paded day of month string( 1 -> 01 )
        FROM
        (
            SELECT      concat(?,'-',n) as date_string                  -- parameterize
            FROM
            (
                SELECT '1' AS n                                         -- Make dynamic table in foolish way due to MySQL dosn't have generator
                UNION SELECT '2'  UNION SELECT '3'  UNION SELECT '4'  UNION SELECT '5'
                UNION SELECT '6'  UNION SELECT '7'  UNION SELECT '8'  UNION SELECT '9'  UNION SELECT '10'
                UNION SELECT '11' UNION SELECT '12' UNION SELECT '13' UNION SELECT '14' UNION SELECT '15'
                UNION SELECT '16' UNION SELECT '17' UNION SELECT '18' UNION SELECT '19' UNION SELECT '20'
                UNION SELECT '21' UNION SELECT '22' UNION SELECT '23' UNION SELECT '24' UNION SELECT '25'
                UNION SELECT '26' UNION SELECT '27' UNION SELECT '28' UNION SELECT '29' UNION SELECT '30'
                UNION SELECT '31' UNION SELECT '32' UNION SELECT '33' UNION SELECT '34' UNION SELECT '35'
            ) AS a
        ) AS b
    ) AS c
    WHERE
        `dom` IS NOT NULL
) AS d
GROUP BY `woy`
