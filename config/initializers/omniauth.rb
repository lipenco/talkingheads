
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  # provider :facebook, '160490800781469', '97d2eaf02ccb3c2fa9b604e65cd950c8' if Rails.env.development?
  # provider :facebook, '583021711715609', 'e41a1ec4d511fa2c6ef0c31ee1993244' if Rails.env.production?
  provider :twitter, 'If6w3RG4lsiZaYxCare3Iw', 'KQ79jk6LS2AdWcBvUnmWwRomjOiQ4VxQmwC1lQDy7A'
  # provider :github, 'a51b4893fbf0e4334f33', '16fd6cc9254cf1c14107611df2698d03c9ae4d95' if Rails.env.development?
  # provider :github, '2bd594c3772434e25e6a', 'f1eadf733dbb8ff4191f115b405760f3f0db8e17' if Rails.env.production?
  # provider :google_oauth2, '720555197870.apps.googleusercontent.com', 'LhaIosmT615E31IW58hAZ8NB'

end
