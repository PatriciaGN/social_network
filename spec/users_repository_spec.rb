require "users_repository"

describe UsersRepository do
    def reset_users_table
        seed_sql = File.read('spec/seeds_users.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network' })
        connection.exec(seed_sql)
    end


    before(:each) do 
        reset_users_table
    end
    
  describe "#all" do
    it "gets all users" do
        repo = UsersRepository.new

        users = repo.all

        users.length 

        expect(users[0].id).to eq "1"
        expect(users[0].username).to eq "username1" 
        expect(users[0].email_address).to eq "email1@email.com"
        
        expect(users[1].id).to eq "2"
        expect(users[1].username).to eq "username2" 
        expect(users[1].email_address).to eq "email2@email.com"
    end
end
  
  describe "#find" do
    it "gets a single user" do  
        repo = UsersRepository.new

        user = repo.find(1)

        expect(user.id).to eq "1" # =>  1
        expect(user.username).to eq "username1" # =>  'post1'
        expect(user.email_address).to eq "email1@email.com" # =>  'content1'
    end
  end
  
  describe "#create" do
    it "creates a new user object with its atributes" do
        repo = UsersRepository.new

        user = User.new
        user.username = "username3"
        user.email_address = "email3@email.com"

        repo.create(user)

        expect(user.username).to eq "username3"
        expect(user.email_address).to eq "email3@email.com"
    end
  end

  describe "#delete" do
    it "deletes a user" do
        repo = UsersRepository.new

        id_to_delete = 1
        repo.delete(id_to_delete)
        all_users = repo.all
        expect(all_users.length).to eq 1 
    end
  end

  describe "#update" do
    it "updates a user" do
        repo = UsersRepository.new

        user = repo.find(1)

        user.username = "updated username"
        user.email_address = "updated@email.com"
        
        repo.update(user)

        updated_user = repo.find(1)

        expect(updated_user.username).to eq "updated username" 
        expect(updated_user.email_address).to eq "updated@email.com" 
    end
  end
end