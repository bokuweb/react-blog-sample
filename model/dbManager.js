(function() {
  var DBManager, Q, mongoose, mongooseCachebox, options;

  mongoose = require('mongoose');

  Q = require('q');

  mongooseCachebox = require('mongoose-cachebox');

  options = {
    cache: true,
    ttl: 240
  };

  mongooseCachebox(mongoose, options);

  DBManager = (function() {
    function DBManager(name, schema) {
      var Schema;
      Schema = mongoose.Schema(schema);
      this._Model = mongoose.model(name, Schema);
    }

    DBManager.prototype.save = function(doc) {
      var d, model;
      d = Q.defer();
      model = new this._Model(doc);
      model.save(function(err) {
        if (err) {
          console.log(error);
          return d.reject();
        } else {
          return d.resolve();
        }
      });
      return d.promise;
    };

    DBManager.prototype.read = function(params) {
      var d, limit, page, skip, sort;
      if (params == null) {
        params = {};
      }
      page = params.page, limit = params.limit, sort = params.sort;
      if (limit == null) {
        limit = 10;
      }
      if (page == null) {
        page = 0;
      }
      if (sort == null) {
        sort = {};
      }
      skip = page * limit;
      d = Q.defer();
      this._Model.find({}).limit(limit).sort(sort).skip(skip).exec(function(err, docs) {
        return d.resolve(docs);
      });
      return d.promise;
    };

    DBManager.prototype.getItems = function(params) {
      var author, category, condition, d, limit, page, q, skip, sort, store, titleCondition, w, word, words;
      page = params.page, limit = params.limit, sort = params.sort, word = params.word, author = params.author;
      if (limit == null) {
        limit = 10;
      }
      if (sort == null) {
        sort = {};
      }
      condition = [];
      if (word != null) {
        word = word.replace(/　/g, " ");
        words = word.split(" ");
        titleCondition = (function() {
          var i, len, results;
          results = [];
          for (i = 0, len = words.length; i < len; i++) {
            w = words[i];
            if (!(w !== '')) {
              continue;
            }
            w = this._pregQuote(w);
            results.push({
              title: new RegExp(w, "i")
            });
          }
          return results;
        }).call(this);
        if (titleCondition.length === 1) {
          condition.push(titleCondition[0]);
        } else if (titleCondition.length > 1) {
          condition.push({
            $and: titleCondition
          });
        }
      }
      if ((author != null) && author !== " ") {
        author = this._pregQuote(author);
        condition.push({
          author: new RegExp(author, "i")
        });
      }
      if ((typeof store !== "undefined" && store !== null) && store !== " ") {
        store = this._pregQuote(store);
        condition.push({
          store: new RegExp(store, "i")
        });
      }

      /*
      else if word?
        if condition[0]?
          authorCondition = for w in words when w isnt '' then {author : new RegExp w, "i"}
          if authorCondition.length is 1
            condition[0] = {$or : [condition[0], authorCondition[0]]}
          else if authorCondition.length > 1
            condition[0] = {$or : [condition[0], {$and : authorCondition}]}
       */
      if ((typeof category !== "undefined" && category !== null) && category !== " ") {
        category = this._pregQuote(category);
        condition.push({
          category: new RegExp(category, "i")
        });
      }
      condition.push({
        isEnable: true
      });
      console.log(condition);
      if (condition.length === 0) {
        q = {};
      } else if (condition.length === 1) {
        q = condition[0];
      } else {
        q = {
          $and: condition
        };
      }
      skip = page * limit;
      d = Q.defer();
      this._Model.find(q).limit(limit).sort(sort).skip(skip).exec(function(err, docs) {
        return d.resolve(docs);
      });
      return d.promise;
    };

    DBManager.prototype.removeStore = function(storeName) {
      var d;
      d = Q.defer();
      this._Model.remove({
        store: storeName
      }, function(err) {
        if (err) {
          return d.reject(err);
        } else {
          return d.resolve();
        }
      });
      return d.promise;
    };

    DBManager.prototype.getNum = function(query) {
      var d;
      if (query == null) {
        query = {};
      }
      d = Q.defer();
      this._Model.count(query).count(function(err, count) {
        if (err) {
          return d.reject(err);
        } else {
          return d.resolve(count);
        }
      });
      return d.promise;
    };

    DBManager.prototype.updateTime = function(url, date) {
      var d;
      d = Q.defer();
      this._Model.findOneAndUpdate({
        url: url
      }, {
        $set: {
          updatedAt: date,
          isEnable: true
        }
      }, {
        "new": true
      }).exec(function(err, docs) {
        if (err) {
          console.log(err);
          return d.reject(err);
        } else {
          return d.resolve();
        }
      });
      return d.promise;
    };

    return DBManager;

  })();

  module.exports = DBManager;

}).call(this);
