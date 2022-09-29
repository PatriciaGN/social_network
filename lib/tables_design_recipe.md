Two Tables Design Recipe Template
Copy this recipe template to design and create two related database tables from a specification.

1. Extract nouns from the user stories or specification
# EXAMPLE USER STORY:
# (analyse only the relevant part - here the final line).

As a social network user,
So I can have my information registered,
I'd like to have a user account with my email address.

As a social network user,
So I can have my information registered,
I'd like to have a user account with my username.

As a social network user,
So I can write on my timeline,
I'd like to create posts associated with my user account.

As a social network user,
So I can write on my timeline,
I'd like each of my posts to have a title and a content.

As a social network user,
So I can know who reads my posts,
I'd like each of my posts to have a number of views.

Nouns: user account, email address, username, post, title, content, number of views

2. Infer the Table Name and Columns
Put the different nouns in this table. Replace the example with your own nouns.

Record	Properties
user	username, email_address
post	        title, content, number_of_views

Name of the first table (always plural): users

Column names: username, email_address

Name of the second table (always plural): posts

Column names: title, content, number_of_views

3. Decide the column types.
Here's a full documentation of PostgreSQL data types.

Most of the time, you'll need either text, int, bigint, numeric, or boolean. If you're in doubt, do some research or ask your peers.

Remember to always have the primary key id as a first column. Its type will always be SERIAL.

# EXAMPLE:

Table: users
id: SERIAL
username: text
email_address: varchar

Table: posts
id: SERIAL
title: text
content: text
number_of_views: int

4. Decide on The Tables Relationship
Most of the time, you'll be using a one-to-many relationship, and will need a foreign key on one of the two tables.

To decide on which one, answer these two questions:

Can one post have many users? (No)
Can one user have many posts? (Yes)
You'll then be able to say that:

[user] has many [posts]
And on the other side, [posts] belongs to [users]
In that case, the foreign key is in the table [posts]
Replace the relevant bits in this example with your own:


4. Write the SQL.
-- EXAMPLE
-- file: users_table.sql

-- Replace the table name, columm names and types.

-- Create the table without the foreign key first.
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username text,
  email_address varchar
);

-- Then the table with the foreign key first.
CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title text,
  content text,
  number_of_views int,

-- The foreign key name is always post_id
  user_id int,
  constraint fk_user foreign key(user_id)
    references users(id)
    on delete cascade
);

5. Create the tables.
psql -h 127.0.0.1 social_network < users_table.sql
psql -h 127.0.0.1 social_network < users_table.sql