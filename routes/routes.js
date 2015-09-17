(function() {
  var config, configRoutes, express, mongoURL, mongoose, router;

  express = require('express');

  mongoose = require('mongoose');

  config = require('config');

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


  /*
  ebooksDB = new EbookDBManager 'ebook',
    title       : String
    author      : String
    url         : String
    #node        : String
    category    : String
    #isbn        : String
    store       : String
    createdAt   : Date
    updatedAt   : Date
    #hasLimit    : Boolean # 期間限定商品?
    canDownload : Boolean
    isEnable    : Boolean
    image       :
      small  : String
      medium : String
      large  : String
  
  scheduler = new CrawlScheduler ebooksDB
  scheduler.start()
   */

  configRoutes = function(app) {
    app.get('/', function(req, res, next) {
      return res.render('index', {});
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
