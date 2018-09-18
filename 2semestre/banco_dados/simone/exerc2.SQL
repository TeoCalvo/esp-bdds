/* EXERCICIO 1 */

    SELECT p_name, p_retailprice
    FROM part
    WHERE p_retailprice > 2097.10

/* EXERCICIO 2 */

    SELECT n_comment
    FROM nation
    WHERE n_name = 'ARGENTINA';

/* EXERCICIO 3 */

    SELECT p_name, p_retailprice
    FROM part
    WHERE p_retailprice BETWEEN 2095.10 AND 2097.90;

/* EXERCICIO 4.1 */

    SELECT l_discount
    FROM lineitem
    WHERE l_shipdate BETWEEN '1998-12-27' AND '1998-12-31';

/* EXERCICIO 4.2 */

    SELECT c_name, c_address FROM customer 
    WHERE c_nationkey = 24 AND c_acctbal > 9990;

/* EXERCICIO 5 */

    SELECT c_name, c_address
    FROM customer 
    WHERE c_nationkey = 24 AND
    c_acctbal > 9990 AND
    c_mktsegment like '%AUTO%';

/* EXERCICIO 6 */

    SELECT c_name, c_address FROM customer
    WHERE c_nationkey=24 AND
    c_acctbal > 9990 AND
    c_mktsegment LIKE '%AUTO%' OR c_mktsegment LIKE '%MAC%');

/* EXERCICIO 7 */

     SELECT * FROM nation
     WHERE n_name NOT LIKE '%A%';

/* EXERCICIO 8 */

    SELECT * FROM nation
    where n_name like '_A%';
