# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_shannonline_session',
  :secret      => '5fc71370d04bda092000be9462d4037e35d285eb0b203342fdfcfd720448cb173abc6b1b28e990ea8c4bc802611e34b20047edd9b64cbe33dbb88f3a3d4a5fce'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
