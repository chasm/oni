class User
  include MongoMapper::Document
  include BCrypt

  before_create :set_password

  attr_reader :password

  key :email, String
  key :digest,  String
  key :salt,  String

  timestamps!

  def authenticate(password)
    digest = BCrypt::Engine.hash_secret(password, self.salt, 12)
    digest == self.digest
  end

  private

  def set_password
    if self.password
      self.salt = BCrypt::Engine.generate_salt
      self.digest = BCrypt::Engine.hash_secret(self.password, self.salt, 12)
    end
  end
end
