require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
  
  it 'saves a new user if all fields are valid' do
    @user = User.new(
      first_name: "first_name",
      last_name: "last_name",
      email: "test@test.com",
      password: "password",
      password_confirmation: "password"
    )
    expect(@user.save).to eq true
  end

  it "returns an error that says password can't be blank" do
    @user = User.new(
      first_name: "first_name",
      last_name: "last_name",
      email: "test@test.com",
      password_digest: ""
    )
    @user.save
    expect(@user.errors.full_messages.to_sentence).to include("Password can't be blank")
  end

  it 'returns an error if the passwords do not match' do
    @user = User.new(
      first_name: "first_name",
      last_name: "last_name",
      email: "test@test.com",
      password: "password",
      password_confirmation: "password_confirmation" 

    )
    @user.save
    expect(@user.errors.full_messages.to_sentence).to eq "Password confirmation doesn't match Password"
  end

  it 'has the password and the password confirmation as the same' do
    @user = User.new(
      first_name: "first_name",
      last_name: "last_name",
      email: "test@test.com",
      password: "password",
      password_confirmation: "password" 

    )
    expect(@user.save).to eq true
  end

  it 'returns an error if the email is not unique' do
    @user = User.new(
      first_name: "first_name",
      last_name: "last_name",
      email: "test@test.com",
      password: "password",
      password_confirmation: "password" 

    )
    @user2 = User.new(
      first_name: "first_name",
      last_name: "last_name",
      email: "Test@test.com",
      password: "password",
      password_confirmation: "password" 

    )
    @user.save
    @user2.save
    expect(@user2.errors.full_messages.to_sentence).to eq "Email has already been taken"
  end

  it 'works even if the emails are in bad case' do
    @user = User.new(
      first_name: "first_name",
      last_name: "last_name",
      email: "Test@test.com",
      password: "password",
      password_confirmation: "password" 

    )
    expect(@user.save).to eq true
  end

  it "returns an error: First name can't be blank" do
    @user = User.new(
      first_name: "",
      last_name: "last_name",
      email: "test@test.com",
      password: "password",
      password_confirmation: "password" 

    )
    @user.save
    expect(@user.errors.full_messages.to_sentence).to eq "First name can't be blank"
  end

  it "returns an error: Last can't be blank" do
    @user = User.new(
      first_name: "first_name",
      last_name: "",
      email: "test@test.com",
      password: "password",
      password_confirmation: "password" 

    )
    @user.save
    expect(@user.errors.full_messages.to_sentence).to eq "Last name can't be blank"
  end

  it "returns an error: Password is too short (minimum is 8 characters) if too short" do
    @user = User.new(
      first_name: "first_name",
      last_name: "last_name",
      email: "test@test.com",
      password: "pass",
      password_confirmation: "pass" 

    )
    @user.save
    expect(@user.errors.full_messages.to_sentence).to eq "Password is too short (minimum is 8 characters)"
  end

end

describe '.authenticate_with_credentials' do
    
    it 'authenticates a user with the proper credentials' do
      @user = User.new(
        first_name: "first_name",
        last_name: "last_name",
        email: "test@test.com",
        password: "password",
        password_confirmation: "password"
      )
      @user.save
      
      @user_login = User.authenticate_with_credentials("test@test.com", "password")
      
      expect(@user_login.email).to eq @user.email
    end

    it 'authenticates a a user if they use spaces in front and in back of email' do
      @user = User.new(
        first_name: "first_name",
        last_name: "last_name",
        email: "test@test.com",
        password: "password",
        password_confirmation: "password"
      )
      @user.save
      
      @user_login = User.authenticate_with_credentials("  test@test.com  ", "password")
      
      expect(@user_login.email).to eq @user.email
    end

    it 'authenticates a a user if they use mixed cases on the email' do
      @user = User.new(
        first_name: "first_name",
        last_name: "last_name",
        email: "test@test.com",
        password: "password",
        password_confirmation: "password"
      )
      @user.save
      
      @user_login = User.authenticate_with_credentials("Test@test.com", "password")
      
      expect(@user_login.email).to eq @user.email
    end

  end

end