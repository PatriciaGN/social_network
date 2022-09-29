require "posts_repository"

describe PostsRepository do
    def reset_posts_table
        seed_sql = File.read('spec/seeds_posts.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network' })
        connection.exec(seed_sql)
    end
      
    before(:each) do 
        reset_posts_table
    end
    
  describe "#all" do
    it "gets all posts" do
        repo = PostsRepository.new

        posts = repo.all

        posts.length 

        expect(posts[0].id).to eq "1"
        expect(posts[0].title).to eq "post1" 
        expect(posts[0].content).to eq "contents1"
        expect(posts[0].number_of_views).to eq "3" 
        expect(posts[0].user_id).to eq "1" 
        
        expect(posts[1].id).to eq "2" 
        expect(posts[1].title).to eq "post2" 
        expect(posts[1].content).to eq "contents2"
        expect(posts[1].number_of_views).to eq "5" 
        expect(posts[1].user_id).to eq "1" 
    end
end
  
  describe "#find" do
    it "gets a single post" do  
        repo = PostsRepository.new

        post = repo.find(1)

        expect(post.id).to eq "1" # =>  1
        expect(post.title).to eq "post1" # =>  'post1'
        expect(post.content).to eq "contents1" # =>  'content1'
        expect(post.number_of_views).to eq "3" #=> '1'
    end
  end
  
  describe "#create" do
    it "creates a new post object with its atributes" do
        repo = PostsRepository.new

        post = Post.new
        post.title =  "new post"
        post.content = "new contents"
        post.number_of_views = "8"
        post.user_id = "2"

        repo.create(post)

        expect(post.title).to eq "new post" #=> "post1"
        expect(post.content).to eq "new contents" #=> "content1"
        expect(post.number_of_views).to eq "8" #=> 1
        expect(post.user_id).to eq "2"
    end
  end

  describe "#delete" do
    it "deletes a post" do
        repo = PostsRepository.new

        id_to_delete = 1
        repo.delete(id_to_delete)
        all_posts = repo.all
        expect(all_posts.length).to eq 1 
    end
  end

  describe "#update" do
    it "updates a post" do
        repo = PostsRepository.new
        
        updated_post = repo.find(1)
        
        updated_post.title = "updated post"
        updated_post.content = "updated content"
        updated_post.number_of_views = 4
        updated_post.user_id = 2
        
        expect(updated_post.title).to eq "updated post"
        expect(updated_post.content).to eq "updated content"
        expect(updated_post.number_of_views).to eq 4
        expect(updated_post.user_id).to eq 2
    end
  end
end