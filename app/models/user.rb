class User < ActiveRecord::Base
  has_secure_password

	# Verify that email field is not blank and that it doesn't already exist in the db (prevents duplicates):
  validates :first_name, presence: true
  validates :last_name, presence: true
	validates :email, presence: true, uniqueness: true
end
