# SPEER

## Run App
Clone the repository and run : <br />
```rails db:migration``` <br />

Run tests with: <br />
```bundle exec rspec``` <br />

Start server with: <br />
```rails s```


Notes: <br />
Chatrooms endpoints has 2 failing tests. The endpoints are working when tested manually, but I need to do more research into how to create dummy instances with the has_many, through association. <br />
Chatroom does not support multiple members yet. Need to learn how to add multiple associations. <br />

All revelant code can be found in: <br />
app/ <br />
config/ <br />
db/ <br />
spec/ <br />

## Endpoints

#### signup
``` http://127.0.0.1:3000/signup ```  <br />
Type: POST <br />
body: <br />
``` { "name": "name", "username": "username", "email": "name@email.com" "password": "password" } ```

#### login
``` http://127.0.0.1:3000/auth/login ``` <br />
Type: POST <br />
body: <br />
``` { "name": "name", "username": "username", "email": "name@email.com" "password": "password" } ```

#### chatroom
``` http://127.0.0.1:3000/chatrooms ``` <br />
Type: GET, POST, PUT, DELETE <br />
body: <br />
``` { "title": "title", "created_by": user_id } ```

#### chat
``` http://127.0.0.1:3000/chatrooms/:chatroom_id/chats ``` <br />
Type: GET, POST, PUT, DELETE <br />
body: <br />
``` { "message": "message", "user_id": user_id, "chatroom_id": chatroom_id } ```

#### tweet
``` http://127.0.0.1:3000/tweets ``` <br />
Type: GET, POST, PUT, DELETE <br />
body: <br />
``` { "tweet": "tweet", "created_by": user_id } ```