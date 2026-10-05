SELECT COUNT(*) AS failed_transactions
FROM transactions
WHERE status = 'FAILED';
SELECT COUNT(*) AS successful_transactions
FROM transactions
WHERE status = 'SUCCESS';
SELECT COUNT(*) AS high_value_transactions
FROM transactions
WHERE amount > 90000;
SELECT *
FROM transactions
WHERE amount > 90000
AND status = 'FAILED';
SELECT COUNT(*) AS high_value_failed
FROM transactions
WHERE amount > 90000
AND status = 'FAILED';SELECT user_id, COUNT(*) AS transaction_count
FROM transactions
GROUP BY user_id
ORDER BY transaction_count DESC
LIMIT 10;
SELECT user_id, COUNT(*) AS failed_count
FROM transactions
WHERE status = 'FAILED'
GROUP BY user_id
ORDER BY failed_count DESC
LIMIT 10;
SELECT
    user_id,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN status = 'FAILED' THEN 1 ELSE 0 END) AS failed_transactions
FROM transactions
GROUP BY user_id
HAVING failed_transactions >= 20
ORDER BY failed_transactions DESC;

SELECT COUNT(*) AS suspicious_users
FROM (
    SELECT user_id
    FROM transactions
    GROUP BY user_id
    HAVING SUM(CASE WHEN status = 'FAILED' THEN 1 ELSE 0 END) >= 20
) AS users;
SELECT
    user_id,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN status = 'FAILED' THEN 1 ELSE 0 END) AS failed_transactions
FROM transactions
GROUP BY user_id
HAVING SUM(CASE WHEN status = 'FAILED' THEN 1 ELSE 0 END) >= 20
ORDER BY failed_transactions DESC;
SELECT
    user_id,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN status = 'FAILED' THEN 1 ELSE 0 END) AS failed_transactions,
    ROUND(
        SUM(CASE WHEN status = 'FAILED' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS failure_rate_percent
FROM transactions
GROUP BY user_id
HAVING SUM(CASE WHEN status = 'FAILED' THEN 1 ELSE 0 END) >= 20
ORDER BY failure_rate_percent DESC;
SELECT
    user_id,
    amount,
    COUNT(*) AS repeat_count
FROM transactions
GROUP BY user_id, amount
HAVING COUNT(*) >= 5
ORDER BY repeat_count DESC
LIMIT 20;
SELECT
    user_id,
    amount,
    COUNT(*) AS repeat_count
FROM transactions
GROUP BY user_id, amount
HAVING COUNT(*) >= 5
ORDER BY repeat_count DESC
LIMIT 1;
SELECT
    status,
    COUNT(*) AS count
FROM transactions
WHERE user_id = 14690
  AND amount = 9999
GROUP BY status;
SELECT
    txn_id,
    user_id,
    amount,
    txn_time,
    status,
    city,
    txn_type
FROM transactions
WHERE user_id = 14690
  AND amount = 9999
ORDER BY txn_time;
SELECT
    user_id,
    DATE(txn_time) AS transaction_date,
    COUNT(*) AS transaction_count
FROM transactions
GROUP BY user_id, DATE(txn_time)
HAVING COUNT(*) >= 5
ORDER BY transaction_count DESC
LIMIT 20;
SELECT
    user_id,
    DATE(txn_time) AS transaction_date,
    COUNT(*) AS transaction_count
FROM transactions
GROUP BY user_id, DATE(txn_time)
HAVING COUNT(*) >= 5
ORDER BY transaction_count DESC
LIMIT 1;
SELECT
    status,
    COUNT(*) AS transaction_count
FROM transactions
WHERE user_id = 14569
  AND DATE(txn_time) = '2024-04-03'
GROUP BY status;
SELECT
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_amount,
    AVG(amount) AS average_amount,
    MAX(amount) AS highest_amount
FROM transactions
WHERE user_id = 14569
  AND DATE(txn_time) = '2024-04-03';
  SELECT
    user_id,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN status = 'FAILED' THEN 1 ELSE 0 END) AS failed_transactions,
    ROUND(
        SUM(CASE WHEN status = 'FAILED' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS failure_rate
FROM transactions
GROUP BY user_id
HAVING
    failed_transactions >= 20
    OR COUNT(*) >= 60
ORDER BY failure_rate DESC, total_transactions DESC;
SELECT COUNT(*) AS number_of_users
FROM (
    SELECT user_id
    FROM transactions
    GROUP BY user_id
    HAVING
        SUM(CASE WHEN status = 'FAILED' THEN 1 ELSE 0 END) >= 20
        OR COUNT(*) >= 60
) AS suspicious_users;
SELECT
    user_id,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN status = 'FAILED' THEN 1 ELSE 0 END) AS failed_transactions,
    ROUND(
        SUM(CASE WHEN status = 'FAILED' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS failure_rate
FROM transactions
GROUP BY user_id
ORDER BY failed_transactions DESC
LIMIT 10;
SELECT
    payment_mode,
    COUNT(*) AS transaction_count,
    SUM(CASE WHEN status = 'FAILED' THEN 1 ELSE 0 END) AS failed_transactions
FROM transactions
WHERE user_id IN (14595, 14593, 14576)
GROUP BY payment_mode
ORDER BY failed_transactions DESC;
SELECT
    city,
    COUNT(*) AS transaction_count,
    SUM(CASE WHEN status = 'FAILED' THEN 1 ELSE 0 END) AS failed_transactions
FROM transactions
WHERE user_id IN (14595, 14593, 14576)
GROUP BY city
ORDER BY failed_transactions DESC;
SELECT
    txn_type,
    COUNT(*) AS transaction_count,
    SUM(CASE WHEN status = 'FAILED' THEN 1 ELSE 0 END) AS failed_transactions
FROM transactions
WHERE user_id IN (14595, 14593, 14576)
GROUP BY txn_type
ORDER BY failed_transactions DESC;
SELECT
    merchant_id,
    COUNT(*) AS transaction_count,
    SUM(CASE WHEN status = 'FAILED' THEN 1 ELSE 0 END) AS failed_transactions
FROM transactions
WHERE user_id IN (14595, 14593, 14576)
GROUP BY merchant_id
ORDER BY failed_transactions DESC
LIMIT 10;
SELECT
    user_id,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN status = 'FAILED' THEN 1 ELSE 0 END) AS failed_transactions,
    ROUND(
        SUM(CASE WHEN status = 'FAILED' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*), 2
    ) AS failure_rate
FROM transactions
GROUP BY user_id
HAVING
    SUM(CASE WHEN status = 'FAILED' THEN 1 ELSE 0 END) >= 20
ORDER BY failed_transactions DESC
LIMIT 10;
SELECT
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN status = 'SUCCESS' THEN 1 ELSE 0 END) AS successful_transactions,
    SUM(CASE WHEN status = 'FAILED' THEN 1 ELSE 0 END) AS failed_transactions,
    ROUND(SUM(amount), 2) AS total_amount,
    ROUND(AVG(amount), 2) AS average_amount,
    ROUND(MAX(amount), 2) AS highest_amount
FROM transactions;
SELECT
    user_id,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN status = 'FAILED' THEN 1 ELSE 0 END) AS failed_transactions,
    ROUND(
        SUM(CASE WHEN status = 'FAILED' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*), 2
    ) AS failure_rate
FROM transactions
GROUP BY user_id
HAVING SUM(CASE WHEN status = 'FAILED' THEN 1 ELSE 0 END) >= 20
ORDER BY failed_transactions DESC
LIMIT 10;
SELECT
    user_id,
    amount,
    COUNT(*) AS repeat_count
FROM transactions
GROUP BY user_id, amount
HAVING COUNT(*) >= 5
ORDER BY repeat_count DESC
LIMIT 10;