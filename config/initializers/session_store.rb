# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :session_key => '_blogging_session',
  :secret      => 'f250d90db753ebd219adf203ad07bb5cf27608e627111a013094bc95fe9d93b70d1b82b3093f7ed9e767b38793cdd4e877696a7c571b10090ea9a838bc61ea62'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
