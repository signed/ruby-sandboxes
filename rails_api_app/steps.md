After each model change run 
- rails db:migrate
- rails db:migrate RAILS_ENV=test

 
1. rails generate scaffold star name:string
2. rails generate migration AddRadiusToStar radius:integer
3. rails generate scaffold planet name:string radius:integer star:references
4. rails generate scaffold moon name:string radius:integer planet:references