# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_web_app_session',
  :secret      => '6f7215f855ff979b8014bf040814dc71e8152b4002add7af7fb6049b2bd0a2413e8ca8c5658c85bf505fb60adaea9f07f1e2bd25326701b2450319f36e6ce779'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
