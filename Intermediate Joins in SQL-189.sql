## 2. Joining Three Tables ##

select a.track_id , b.name track_name , c.name track_type ,b.unit_price , quantity
from invoice_line a inner join  track b on a.track_id = b.track_id
inner join media_type c on c.media_type_id= b.media_type_id
where invoice_id  =4


## 3. Joining More Than Three Tables ##

select a.track_id , b.name track_name ,e.name artist_name,   c.name track_type ,b.unit_price , quantity
from invoice_line a inner join  track b on a.track_id = b.track_id
inner join media_type c on c.media_type_id= b.media_type_id
inner join album d on d.album_id= b.album_id
inner join artist e on e.artist_id= d.artist_id
where invoice_id  =4


## 4. Combining Multiple Joins with Subqueries ##

 SELECT
   ta.album ,  ta.artist_name artist,
    COUNT(*) tracks_purchased
FROM invoice_line il
INNER JOIN (
              SELECT
                t.track_id,
                ar.name artist_name, al.title album
            FROM track t
            INNER JOIN album al ON al.album_id = t.album_id
            INNER JOIN artist ar ON ar.artist_id = al.artist_id
           ) ta
           ON ta.track_id = il.track_id
GROUP BY 1 ,2 
ORDER BY 3 DESC LIMIT 5;

## 5. Recursive Joins ##


SELECT e2.first_name  || ' ' || e2.last_name employee_name    , e2.title employee_title ,
 e1.first_name  || ' ' || e1.last_name supervisor_name , e1.title supervisor_title  
 from employee e2 left join employee e1 
 on e1.employee_id =e2.reports_to 
 order by employee_name

## 6. Pattern Matching Using Like ##

select first_name , last_name,phone from customer where first_name like '%Belle%'

## 7. Generating Columns With The Case Statement ##

SELECT
   c.first_name || " " || c.last_name customer_name,
   COUNT(i.invoice_id) number_of_purchases,
   SUM(i.total) total_spent,
   CASE
       WHEN sum(i.total) < 40 THEN 'small spender'
       WHEN sum(i.total) > 100 THEN 'big spender'
       ELSE 'regular'
       END
       AS customer_category
FROM invoice i
INNER JOIN customer c ON i.customer_id = c.customer_id
GROUP BY 1 ORDER BY 1