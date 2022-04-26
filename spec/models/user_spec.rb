require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do 
    it "shoud sucessfully save a valid user if password confirmation maches password" do
      @user = User.create(
        first_name: 'Jack', 
        last_name: 'Johnson', 
        email: '12345@gmail.com',
        password: '123456', 
        password_confirmation: '123456'
      )
      expect(@user).to be_valid
    end

    it "should not save a valid user if password and password doesn't match" do
      @user = User.create(
        first_name: 'Jack', 
        last_name: 'Johnson', 
        email: '12345@gmail.com',
        password: '123456', 
        password_confirmation: '1234567'
      )
      expect(@user).to_not be_valid
    end

    it "should not save a valid user if email is already exist" do
      @user1 = User.create(
        first_name: 'Jack', 
        last_name: 'Johnson', 
        email: 'jack@gmail.com',
        password: '123456', 
        password_confirmation: '123456'
      )
      @user2 = User.create(
        first_name: 'Hello', 
        last_name: 'Kitty', 
        email: 'jack@gmail.com',
        password: '123456', 
        password_confirmation: '123456'
      )
      expect(@user1).to be_valid
      expect(@user2).to_not be_valid
    end

    it "should return error if no first name is provided" do
      @user = User.create(
        first_name: nil, 
        last_name: 'Johnson', 
        email: '12345@gmail.com',
        password: '123456', 
        password_confirmation: '123456'
      )
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it "should return error if no last name is provided" do
      @user = User.create(
        first_name: 'Jack', 
        last_name: nil, 
        email: '12345@gmail.com',
        password: '123456', 
        password_confirmation: '123456'
      )
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it "should return error if no name is provided" do
      @user = User.create(
        first_name: 'Jack', 
        last_name: 'Johnson', 
        email: nil,
        password: '123456', 
        password_confirmation: '123456'
      )
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "should not save a valid user if no name is provided" do
      @user = User.create(
        first_name: 'Jack', 
        last_name: 'Johnson', 
        email: nil,
        password: '123456', 
        password_confirmation: '123456'
      )
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "should return error if password length is less than 6" do
      @user = User.create(
        first_name: 'Jack', 
        last_name: 'Johnson', 
        email: nil,
        password: '12345', 
        password_confirmation: '12345'
      )
      expect(@user).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    # examples for this class method here
    it "tests class method return correct user" do
      @user1 = User.create(
        first_name: 'Jack', 
        last_name: 'Johnson', 
        email: 'jack@gmail.com',
        password: '123456', 
        password_confirmation: '123456'
      )

      @user2 = User.authenticate_with_credentials('jack@gmail.com', '123456')
      expect(@user1.id).to be(@user2.id)
    end

    it "should log user in if email has spaces" do
      @user1 = User.create(
        first_name: 'Jack', 
        last_name: 'Johnson', 
        email: 'jack@gmail.com',
        password: '123456', 
        password_confirmation: '123456'
      )

      @user2 = User.authenticate_with_credentials(' jack@gmail.com  ', '123456')
      expect(@user1.id).to be(@user2.id)
    end

    it "should log user in if in wrong cases" do
      @user1 = User.create(
        first_name: 'Jack', 
        last_name: 'Johnson', 
        email: 'jack@gmail.com',
        password: '123456', 
        password_confirmation: '123456'
      )

      @user2 = User.authenticate_with_credentials('JaCk@gMaiL.CoM', '123456')
      expect(@user1.id).to be(@user2.id)
    end
  end

end
