1. Design and create the Table
If the table is already created in the database, you can skip this step.

Otherwise, follow this recipe to design and create the SQL schema for your table.

In this template, we'll use an example table students

# EXAMPLE

Table: posts

Columns:
id | title | contents | number_of_views

2. Create Test SQL seeds
Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

-- EXAMPLE
-- (file: spec/seeds_posts.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE posts RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO posts (title, contents, number_of_views) VALUES ('post1', 'contents1', '3');
INSERT INTO posts (title, contents, number_of_views) VALUES ('post2', 'contents2', '5');

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

psql -h 127.0.0.1 social_network < seeds_posts.sql


3. Define the class names
Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.

# EXAMPLE
# Table name: posts

# Model class
# (in lib/posts.rb)
class Post
end

# Repository class
# (in lib/posts_repository.rb)
class PostsRepository
end

4. Implement the Model class
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

# EXAMPLE
# Table name: posts

# Model class
# (in lib/posts.rb)

class Post

  # Replace the attributes by your own columns.
  attr_accessor :id, :title, :contents, :number_of_views
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name
You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.

5. Define the Repository Class interface
Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

# EXAMPLE
# Table name: posts

# Repository class
# (in lib/posts_repository.rb)

class PostsRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, cohort_name FROM students;

    # Returns an array of Student objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, cohort_name FROM students WHERE id = $1;

    # Returns a single Student object.
  end

  # Add more methods below for each operation you'd like to implement.

  # def create(post)
     # Insert a new post record
     # Takes a Post object in argument
     # Executes the SQL query: "INSERT INTO posts (title, contents, number_of_views) VALUES( $1, $2, $3);"
     # Doesn't return anything (only creates the record)
  # end

  # def update(post)
    # Updates an post record
    # Takes a Post objecty (with the updated fields)
    # Executes the SQL: "UPDATE posts SET title = $1, contents = $2, number_of_views = $3, id = $4;"
    # Returns nothing(only updates the record)
  # end

  # def delete(post)
      # Deletes an post record given its id
      # Executes the SQL: "DELETE FROM posts WHERE id = $1;"
      #Returns nothing
  # end
end

6. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

# EXAMPLES

# 1
# Get all posts

repo = PostsRepository.new

posts = repo.all

posts.length # =>  2

posts[0].id # =>  1
posts[0].title # =>  'post1'
posts[0].content # =>  'content1'
post[0].number_of_views #=> '1'

posts[1].id # =>  2
posts[1].title # =>  'post2'
posts[1].content # =>  'content2'
post[1].number_of_views #=> '2'


# 2
# Get a single post

repo = PostsRepository.new

posts = repo.find(1)

posts.id # =>  1
posts.title # =>  'post1'
posts.content # =>  'content1'
post.number_of_views #=> '1'

# 3 Creates a new post object with its atributes
repo = PostsRepository.new

post = Post.new
post.title =  "post1"
post.content = "content1"
post.number_of_views = 1

repository.create(post)

post.title #=> "post1"
post.content #=> "content1"
post.number_of_views" #=> 1

# 4 Deletes a post
repo = PostsRepository.new

id_to_delete = 1
repo.delete(id_to_delete)
all_posts = repo.all
all_posts.length #=> 0

# 5 Updates a post
repo = PostsRepository.new

updated_post = repo.find(1)

updated_post.title = "updated post"
updated_post.content = "updated content"
updated_post.number_of_views = 4

post.title #=> "updated post"
post.content = "updated content"
post.number_of_views = 4

7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

# file: spec/posts_repository_spec.rb

def reset_posts_table
  seed_sql = File.read('spec/seeds_posts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'posts' })
  connection.exec(seed_sql)
end

describe PostsRepository do
  before(:each) do 
    reset_posts_table
  end

  # (your tests will go here).
end
8. Test-drive and implement the Repository class behaviour
After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.

