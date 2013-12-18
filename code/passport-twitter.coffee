passport = require('passport')
twitter = require('passport-twitter')

keys = {
  consumerKey: TWITTER_CONSUMER_KEY
  consumerSecret: TWITTER_CONSUMER_SECRET
  callbackURL: "http://127.0.0.1:3000/auth/twitter/callback"
}

passport.use new twitter.Strategy keys, (t, ts, profile, done) ->
  findOrCreateUserPlz { twitterId: profile.id }, (err, user) ->
    done(err, user)

app.use(passport.initialize())
app.use(passport.authenticate('twitter'))
