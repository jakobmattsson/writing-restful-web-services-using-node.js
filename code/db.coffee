mongoose = require 'mongoose'
ObjectId = mongoose.Schema.ObjectId

mongoose.connect 'mongodb://localhost/tamblr'

model = (name, schema) ->
  mongoose.model name, new mongoose.Schema schema,
    strict: true

users = model 'users',
  name:
    type: String
    default: ''
  bio:
    type: String
    default: 'IE6-lover'
  age:
    type: Number
    default: null

blogs = model 'blogs',
  name:
    type: String
    default: ''
  description:
    type: String
    default: ''
  users:
    type: ObjectId
    ref: 'users'

posts = model 'posts',
  title:
    type: String
    default: ''
  body:
    type: String
    default: ''
  published:
    type: Date
  blogs:
    type: ObjectId
    ref: 'blogs'


list = (model, callback) ->
  model.find {}, callback

get = (model, id, callback) ->
  model.findById id, callback

del = (model, id, callback) ->
  model.remove { _id: id }, callback

put = (model, id, data, callback) ->
  model.update { _id: id }, data, { multi: false }, callback

post = (model, data, callback) ->
  new model(data).save callback
