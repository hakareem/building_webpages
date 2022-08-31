# Installing Heroku CLI
```ruby
brew tap heroku/brew && brew install heroku
```

# Project Setup
```ruby
$ cd my-web-project/

# Skip the git setup if already done.
$ git init
$ git branch -m main

# Login into heroku
# This will automatically open a page in your web browser
# to login using Heroku's website. Once it's done, you can 
# go back to your terminal.
$ heroku login

# Create an heroku app
$ heroku create
# This command will modify Gemfile.lock - make sure to
# 'git add' it again if needed. 
$ bundle lock --add-platform x86_64-linux

# Add files and commit
$ git add .
$ git commit -m "Web application setup"

# Push and deploy to heroku
$ git push heroku main

# Heroku will then output a bunch of logs 
# while deploying.

# It should give you the URL of your deployed app
# once finished (for example, https://young-tundra-27419.herokuapp.com)
```

# Using a PostgreSQL Database on Heroku

```ruby

# This adds an Heroku addon to your application, with the 
# 'hobby-dev' plan, which is the basic free Heroku plan.
$ heroku addons:create heroku-postgresql:hobby-dev

# This will launch a psql REPL connected
# to the remote Heroku database. Once you're
# in this REPL, you can load the SQL structure
# and seeds of your tables by copy pasting the SQL
# code in there.
$ heroku pg:psql

```

# Database Connection

```ruby
def self.connect
  # If the environment variable (set by Heroku)
  # is present, use this to open the connection.
  if ENV['DATABASE_URL'] != nil
    @connection = PG.connect(ENV['DATABASE_URL'])
    return
  end

  if ENV['ENV'] == 'test'
    database_name = 'music_library_test'
  else
    database_name = 'music_library'
  end
  @connection = PG.connect({ host: '127.0.0.1', dbname: database_name })
end

```