class User < ActiveRecord::Base
  has_secure_password

	# Verify that email field is not blank and that it doesn't already exist in the db (prevents duplicates):
  validates :first_name, presence: true
  validates :last_name, presence: true
	validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

  def self.authenticate_with_credentials(email, password)
    user = User.find_by(email: email.downcase.strip)
    user && user.authenticate(password) ? user : nil
  end
end
