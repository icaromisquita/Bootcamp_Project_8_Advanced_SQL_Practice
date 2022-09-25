use publications;

select * from authors;


-- Replicate the example function from the video 
-- https://www.youtube.com/watch?v=jVx7SYouZKk&t=8s
-- Using the authors table from the publications dataset
drop function full_name;
CREATE FUNCTION full_name(
	first_name varchar(20), 
    last_name varchar(40)
    )
RETURNS varchar(60) deterministic
RETURN concat(first_name, " ", last_name);
-- calling the function
select full_name(au_fname, au_lname) as full_name
from authors;

/*Create a function that computes the 
 advance that an author gets
*/
drop function money_per_author;
create function money_per_author(
	amount float, 
    percentage int
    )
returns float(2) deterministic
return round((amount * percentage / 100), 2);
-- test the function
select 
	t.title_id,
    t.title,
    a.au_fname,
    t.advance,
    ta.royaltyper,
    money_per_author(t.advance, ta.royaltyper) as money_author
from titles t
left join titleauthor ta on t.title_id = ta.title_id
left join authors a on ta.au_id = a.au_id;

/*Create a function that computes the 
 royalty that an author gets
*/

drop function royalty_per_author;
create function royalty_per_author(
	price float, qty int, 
    royalty float, royaltyper int)
returns float(2) deterministic
return round(
	(price * qty * royalty / 100 * royaltyper / 100), 2);

-- test the function
SELECT 
    t.title_id,
    ta.au_id,
    full_name(a.au_fname, a.au_lname),
	royalty_per_author(t.price, s.qty, t.royalty, ta.royaltyper) AS sales_royalty
FROM
    sales s
        LEFT JOIN
    titles t ON s.title_id = t.title_id
        LEFT JOIN
    titleauthor ta ON t.title_id = ta.title_id
		LEFT JOIN
	authors a on ta.au_id = a.au_id;

