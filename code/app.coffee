express = require('express')

app = express()

app.get '/', (req, res) ->
  res.send('Hello World')

app.get '/users/:id', (req, res)->
  res.send('user ' + req.params,id)

app.listen(3000)
