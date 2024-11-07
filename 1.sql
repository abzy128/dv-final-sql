-- List of clients with a continuous history for the year, that is, every month on a regular basis without omissions
-- for the specified annual period, the average receipt for the period from 06/01/2015 to 06/01/2016,
-- the average amount of purchases per month, the number of all transactions per client for the period

SELECT ci."Id_client",
       ci."Total_amount" / 12.0                                                AS "Average_receipt",
       SUM(ti."Sum_payment") / COUNT(DISTINCT EXTRACT(MONTH FROM ti.date_new)) AS "Average_amount_per_month",
       COUNT(DISTINCT ti."Id_check")                                           AS "Number_of_transactions"
FROM customer_info ci
         JOIN transaction_info ti ON ci."Id_client" = ti."ID_client"
WHERE ti.date_new BETWEEN '2015-06-01' AND '2016-06-01'
GROUP BY ci."Id_client",
         ci."Total_amount"
HAVING COUNT(DISTINCT EXTRACT(MONTH FROM ti.date_new)) = 12
ORDER BY COUNT(DISTINCT ti."Id_check") DESC;