/* EXERCICIO 1 */

    SELECT T1.P_NAME,
           T1.P_RETAILPRICE,
           T2.PS_SUPPLYCOST 
    FROM PART AS T1,
         PARTSUPP AS T2
    WHERE T1.P_PARTKEY = T2.PS_PARTKEY AND
          T1.P_RETAILPRICE > 2097.10;

/* EXERCICIO 2 */

    SELECT T1.O_ORDERSTATUS,
           T2.L_DISCOUNT
    FROM ORDERS AS T1,
         LINEITEM AS T2
    WHERE T1.O_ORDERKEY = T2.L_ORDERKEY
    AND T2.L_SHIPDATE BETWEEN '1998-11-11' AND '1998-12-31';

/* EXERCICO 3 */

    SELECT T1.O_ORDERPRIORITY,
           T2.C_NAME,
           T2.C_ADDRESS
    FROM ORDERS AS T1,
         CUSTOMER AS T2,
         NATION AS T3
    WHERE T1.O_CUSTKEY = T2.C_CUSTKEY AND
          T2.C_NATIONKEY = T3.N_NATIONKEY AND
          T3.N_NAME = 'UNITED STATES' AND
          T2.C_ACCTBAL > 9990;

/* EXERCICIO 4 */

    SELECT T1.C_NAME
    FROM CUSTOMER AS T1,
         NATION AS T2
    WHERE T1.C_NATIONKEY = T2.N_NATIONKEY AND
          T1.C_ACCTBAL > 9990 AND
          T1.C_MKTSEGMENT LIKE '%AUTO%' AND
          T2.N_NAME = 'UNITED STATES';

/* EXERCICIO 5 */

SELECT T1.C_NAME,
       T3.O_TOTALPRICE
    FROM CUSTOMER AS T1,
         NATION AS T2,
         ORDERS AS T3
    WHERE T1.C_NATIONKEY = T2.N_NATIONKEY AND
          T1.C_CUSTKEY = T3.O_CUSTKEY AND
          T2.N_NAME = 'BRAZIL';
