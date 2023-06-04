# How to delete the database with all data and start from scratch?

See [rails db:*](https://guides.rubyonrails.org/active_record_migrations.html#running-migrations)
Append `RAILS_ENV=test` to run the schema change on the test database.

1. rails db:reset
   1. rails db:drop
   2. rails db:setup


https://stackoverflow.com/questions/4116067/purge-or-recreate-a-ruby-on-rails-database