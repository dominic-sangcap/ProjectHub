CREATE EXTENSION hstore;

-- create new table
CREATE TABLE books (
   id serial primary key,
   title text,
   attributes hstore);


-- insert into table
INSERT INTO books (title, attributes) VALUES 
	('SQL for Data Science', 
	'language=>English,
	page_cnt=>500,
	pub_year=>2021');

-- insert another value into table
INSERT INTO books (title, attributes) VALUES 
	('SQL for Data Science 2', 
	'page_cnt=>600,
	pub_year=>2021,
	author_cnt=>3');

-- hstore values do not initially work with attribute = ''
select title, attributes->'page_cnt'
from books
where attributes->'author_cnt'='3'


