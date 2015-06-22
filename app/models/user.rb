class User < ActiveRecord::Base
  attr_accessor :password
  before_save :encrypt_password
  
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :password, :on => :create
  
  has_and_belongs_to_many :permissions
  has_and_belongs_to_many :groups
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
  
  def self.auth(name, password)
    user = User.find_by_name(name)
	if user and BCrypt::Engine.hash_secret(password, user.password_salt) == user.password_hash
	  user
	else
	  nil
	end
  end
end
