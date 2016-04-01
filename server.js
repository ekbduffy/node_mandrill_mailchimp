var express = require('express');
var basicAuth = require('basic-auth');
var Cacheman = require('cacheman');
var swig = require("swig");
var bodyParser = require('body-parser');
var config = require('./config.js');
var mandrill = require('mandrill-api/mandrill');
var mysql = require('./db.js');
var bodyParser = require('body-parser');


var app = module.exports.app = exports.app = express();

app.engine('swig', swig.renderFile);



app.set('view engine', 'swig');
app.set('views', __dirname + '/views');
app.disable('x-powered-by');
app.use(express.static('assets'));
app.use(bodyParser.urlencoded({extended: true})); 

var cache = new Cacheman({ ttl: 1000 });

var mandrill_client = new mandrill.Mandrill(config.api.mandrillkey);






app.get('/', function (req, res) {    
        cache.wrap('mandrillstat', function(callback){
            mandrill_client.users.info(function(result){
                callback(null,result);
            });                    
        }, '1000s', function (err, result) {
            return  res.render('homepage',{req:req,info:{'mandrillstat':result,'mailchimp':{}}});
        });                
});


app.use('/campaign', require('./controllers/campaigns.js'));
app.use('/list', require('./controllers/lists.js'));
app.use('/sending', require('./controllers/sendings.js'));


app.all('*',function(req,res){
            res.status(404).render('404');
})

var server = app.listen(process.env.PORT || 1337, function () {
  var host = server.address().address;
  var port = server.address().port;

  console.log('Test app listening at http://%s:%s', host, port);
});				