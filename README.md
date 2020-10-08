# SPEER

## Installation
```bundle install```

## Run App
``` rails s```

## Run Migration
```rails db:migration```

## Run Tests
```bundle exec rspec```

## Endpoints

#### signup
``` http://127.0.0.1:3000/signup ``` 
Type: POST
body:
``` { "name": "name", "username": "username", "email": "name@email.com" "password": "password" } ```

#### login
``` http://127.0.0.1:3000/auth/login ```
Type: POST
body:
``` { "name": "name", "username": "username", "email": "name@email.com" "password": "password" } ```
