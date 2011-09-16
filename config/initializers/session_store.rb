# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_math-chat_session',
  :secret      => 'b000122e88e80f8111382ced0d966c3a1cc8e50a66febc4780f315b9f88f3976dfa05f4ac8b6e824bd032ebc0b769336681738afff364380f2316c4975fcde55'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
