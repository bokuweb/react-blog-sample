(function() {
  var DBManager, blogDB, config, configRoutes, express, mongoURL, mongoose, router;

  express = require('express');

  mongoose = require('mongoose');

  config = require('config');

  DBManager = require('../model/dbManager');

  router = express.Router();

  if (process.env.OPENSHIFT_MONGODB_DB_URL != null) {
    mongoURL = process.env.OPENSHIFT_MONGODB_DB_URL + process.env.OPENSHIFT_APP_NAME;
  } else {
    mongoURL = "mongodb://localhost:27017/reactBlog";
  }

  mongoose.connect(mongoURL);

  process.on('SIGINT', function() {
    return mongoose.connection.close(function() {
      console.log('Mongoose disconnected on app termination');
      return process.exit(0);
    });
  });

  blogDB = new DBManager('blog', {
    title: String,
    text: String,
    author: String,
    createdAt: Date,
    updatedAt: Date
  });

  configRoutes = function(app) {
    app.get('/', function(req, res) {
      return res.render('index', {});
    });
    app.post('/api/v1/save', function(req, res) {
      console.dir(req.body);
      blogDB.save(req.body);
      return res.json(req.body);
    });
    app.get('/api/v1/read', function(req, res) {
      return blogDB.read().then((function(_this) {
        return function(docs) {
          console.log(docs);
          return res.json(docs);
        };
      })(this));
    });
    if (app.get('env' === 'development')) {
      app.use(function(err, req, res, next) {
        res.status(err.status || 500);
        res.render('error', {
          message: err.message,
          error: err
        });
      });
    }
    return app.use(function(err, req, res, next) {
      res.status(err.status || 500);
      return res.render('error', {
        message: err.message,
        error: {}
      });
    });
  };

  module.exports = {
    configRoutes: configRoutes
  };

}).call(this);
