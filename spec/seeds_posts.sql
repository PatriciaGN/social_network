
TRUNCATE TABLE posts, users RESTART IDENTITY; -- replace with your own table name.
 -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.
INSERT INTO users (username, email_address) VALUES ('username1', 'email1@email.com');

INSERT INTO posts (title, content, number_of_views, user_id) VALUES ('post1', 'contents1', '3', 1);
INSERT INTO posts (title, content, number_of_views, user_id) VALUES ('post2', 'contents2', '5', 1);
