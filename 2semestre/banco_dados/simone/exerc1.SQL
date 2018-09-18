/* EXERCICIO 1 */

    SELECT * FROM NATION;

/* EXERCICIO 2 */

    SELECT n_comment,  n_name FROM NATION;

/* EXERCICIO 3 */

    SELECT o_orderpriority FROM orders;

/* EXERCICIO 4 */

    SELECT l_discount FROM LINEITEM;

/* EXERCICIO 5 */

    Apenas a alternativa 1)

/* EXERCICIO 6 */

    /* 2 */
    select n_name from nation;

    /* 3 */
    select r_name , r_comment from region;

    /* 4 */
    select p_name, 12 * p_retailprice from part;

/* EXERCICIO 7 */

    SELECT (p_name || '---' || p_type) as "Nome e Tipo" FROM part;
