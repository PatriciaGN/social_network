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