class AuthenticateUser
    def initialize(username, email, password)
        @username = username
        @email = email
        @password = password
    end
  
    # Service entry point
    def call
        JsonWebToken.encode(user_id: user.id) if user
    end
  
    private
  
    attr_reader :username, :email, :password
  
    # verify user credentials
    def user
        user = User.find_by(username: username)
        return user if user && user.authenticate(password)
        # raise Authentication error if credentials are invalid
        raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
    end
end