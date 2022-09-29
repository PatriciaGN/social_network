require "post"

describe Post do
    it "generates the variables title, content and number_of_views" do
        post = Post.new
        post.title = "post1"
        post.content = "contents1"
        post.number_of_views = "number of views"
    end
end

