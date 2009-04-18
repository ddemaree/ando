# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_practicalmadness_session',
  :secret      => '65ee13872b3b9a6c996c3399dab10d9afb620a6499547a680e721e502c717822305dbbf4f61d68027b6d44d79247d9306e55aea28f6fca5b620eb7ba574f505f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
