-- age groups of clients in increments of 10 years and separately clients who do not have this information,
-- with the parameters amount and number of transactions for the entire period, and quarterly - averages and %.

SELECT CASE
           WHEN ci."Age" IS NULL THEN 'Undefined'
           ELSE (FLOOR((ci."Age" - 1) / 10) * 10 + 1) || '-' || (FLOOR((ci."Age" - 1) / 10) * 10 + 10)
           END                                  AS "Age_group",
       SUM(ti."Sum_payment")                    AS "Total_amount",
       COUNT(ti."Id_check")                     AS "Number_of_transactions",
       AVG(ti."Sum_payment")                    AS "Average_amount",
       CONCAT(CAST(CAST(COUNT(ti."Id_check") AS DECIMAL) /
                   (SELECT COUNT(ti."Id_check") FROM transaction_info ti) *
                   100 AS NUMERIC(10, 2)), '%') AS "Share_of_total_number_of_transactions"
FROM customer_info ci
         JOIN transaction_info ti ON ci."Id_client" = ti."ID_client"
GROUP BY CASE
             WHEN ci."Age" IS NULL THEN 'Undefined'
             ELSE (FLOOR((ci."Age" - 1) / 10) * 10 + 1) || '-' || (FLOOR((ci."Age" - 1) / 10) * 10 + 10)
             END