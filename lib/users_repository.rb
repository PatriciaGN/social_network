require "user"

class UsersRepository
    def all
        users = []
        sql = "SELECT id, username, email_address FROM users;"
        result_set = DatabaseConnection.exec_params(sql,[])

        result_set.each do |each_user|
            user = User.new
            user.id = each_user["id"]
            user.username = each_user["username"]
            user.email_address = each_user["email_address"]

            users << user
        end
        return users
    end

    def find(id)
        sql = "SELECT id, username, email_address FROM users WHERE id = $1"
        sql_params = [id]

        result_set = DatabaseConnection.exec_params(sql, sql_params)

        record = result_set[0]

        user = User.new
        user.id = record['id']
        user.username = record['username']
        user.email_address = record['email_address']

        return user
    end

    def create(user)
        sql = "INSERT INTO users (username, email_address) VALUES ($1, $2);"
        sql_params = [user.username, user.email_address]

        DatabaseConnection.exec_params(sql, sql_params)
    end

    def delete(id)
        sql = "DELETE FROM users WHERE id = $1;"
        sql_params = [id]

        DatabaseConnection.exec_params(sql, sql_params)
    end

    def update(user)
      sql = "UPDATE users SET username = $1, email_address = $2 WHERE id = $3;"
      sql_params = [user.username, user.email_address, user.id]

      DatabaseConnection.exec_params(sql, sql_params)

    end
end