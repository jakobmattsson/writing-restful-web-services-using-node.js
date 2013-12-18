passport = require('passport')
passportLocal = require('passport-local')

passport.use new passportLocal.Strategy (user, pass, done) ->
  findUserPlz { username: user, password: pass }, (err, user) ->
    done(err, user)

app.use(passport.initialize())
app.use(passport.authenticate('local'))
