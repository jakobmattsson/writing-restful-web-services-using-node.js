models = [users, blogs, posts]

Object.keys(models).forEach (modelName) ->

  app.get '/#{modelName}', (req, res) ->
    list models[modelName], (err, data) ->
      res.json data

  app.get '/#{modelName}/:id', (req, res) ->
    get models[modelName], req.params.id, (err, data) ->
      res.json data

  app.post '/#{modelName}', (req, res) ->
    post models[modelName], req.body, (err, data) ->
      res.json data

  app.del '/#{modelName}/:id', (req, res) ->
    del models[modelName], req.params.id, (err, count) ->
      res.json { count: count }

  app.put '/#{modelName}/:id', (req, res) ->
    put models[modelName], req.params.id, req.body, (err, count) ->
      res.json { count: count }

  paths = models[modelName].schema.paths
  owners = Object.keys(paths).filter (p) ->
    paths[p].options.type == ObjectId &&
    typeof paths[p].options.ref == 'string'
  .map (x) -> paths[x].options.ref

  owners.forEach (owners) ->
    app.get "/#{owner}/:id/#{name}" , (res, req) ->
      listSub models[name], owner, req.params.id, (err, data) ->
        res.json data

    app.post "/#{owner}/:id/#{name}" , (res, req) ->
      postSub models[name], req.body, owner, req.params.id, (err, data) ->
        res.json data

