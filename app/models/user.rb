class User
  include MongoMapper::Document # Make this a persistable Mongo model
  include BCrypt

  # Run this method before creating new Users
  before_create :set_password

  # Create a setter for the password so we can create
  # new users by passing email and password
  attr_reader :password

  key :email, String
  key :digest,  String    # Store the hashed password
  key :salt,  String      # Store the salt used to hash the password

  timestamps! # Create timestamps automatically

  # Authenticate the user by passing this password
  def authenticate(password)
    # Hash the passed in password
    digest = BCrypt::Engine.hash_secret(password, self.salt, 12)
    # Compare the hashed password with the stored digest
    # Returns true if authenticated, false if not
    digest == self.digest
  end

  private

  def set_password
    # If a password has been passed in to #create
    if self.password
      # Generate a salt
      self.salt = BCrypt::Engine.generate_salt
      # Use the salt to hash the passed-in password and save the hash as digest
      self.digest = BCrypt::Engine.hash_secret(self.password, self.salt, 12)
    end
  end
end
