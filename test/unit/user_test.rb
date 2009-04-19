require 'test_helper'

class UserTest < ActiveSupport::TestCase

  should_not_allow_mass_assignment_of :email_confirmed,
    :salt, :encrypted_password,
    :token, :token_expires_at
    
    # signing up

    context "When signing up" do
      should_validate_presence_of :email, :password
      should_allow_values_for     :email, "foo@example.com"
      should_not_allow_values_for :email, "foo"
      should_not_allow_values_for :email, "example.com"

      should "require password confirmation on create" do
        user = Factory.build(:user, :password              => 'blah',
                                    :password_confirmation => 'boogidy')
        assert ! user.save
        assert user.errors.on(:password)
      end

      should "store email in exact case" do
        user = Factory(:user, :email => "John.Doe@example.com")
        assert_equal "John.Doe@example.com", user.email
      end
    end

    context "When multiple users have signed up" do
      setup { @user = Factory(:user) }
      should_validate_uniqueness_of :email
    end
    
    # authenticating

    context "A user" do
      setup do
        @user     = Factory(:user)
        @password = @user.password
      end

      should "authenticate with good credentials" do
        assert User.authenticate(@user.email, @password)
        assert @user.authenticated?(@password)
      end

      should "not authenticate with bad credentials" do
        assert ! User.authenticate(@user.email, 'bad_password')
        assert ! @user.authenticated?('bad_password')
      end
    end

end
