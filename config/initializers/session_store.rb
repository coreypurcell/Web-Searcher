# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_product_search_session',
  :secret      => '4c7d6da1af37a5d67dbb8c1dd06e9f004c540c2e7040bbd506cf9da6f57bce2f2dc15ea108facda307d7e54299db6efd930f58e2cd88ea6858661034a33640ba'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
