express = require('express')
app = express.createServer()

before1 = (req, res, next) ->
  req.foo = 'bar'
  next()

before2 = (req, res, next) ->
  res.header('X-Time', new Date().getTime())
  next()

app.get '/', before1, (req, res) ->
  res.send('Hello World')

app.get '/users/:id', [before1, before2], (req, res)->
  res.send('user ' + req.params,id)

app.listen(3000)