var config = require('./config.js');
var mysql = require('./db.js');
var async = require('async');
var nodemailer = require('nodemailer');
var swig = require('swig');

var templates = {};
module.exports.templates = templates;

var limiters = [];
/*
{'mail.ru':[
    {}
]}



*/

var config = {  direct:{name:"sender.eleview.com"},
                debug :true    
            };
            
var transporter = nodemailer.createTransport(config);




var q = async.queue(function(task, queue_callback){
    if(typeof templates[task.campaign] == 'undefined'){
        
        tpl = swig.compile('{{ tacos }}');
        mysql.getConnection(function(error,db){
            if(error){
                console.log(error);
                queue_callback();
            }
                
            db.query('SELECT *, s.campaign FROM sending s LEFT JOIN listemails l ON (l.listid = s.list) WHERE s.id =?  AND l.subscribed = 1 AND l.email NOT IN (SELECT email FROM listemails WHERE listid = s.excludeList)', [req.params.id],function(error, emails){            
                db.release();
                if(error){                
                    err = error.message;
                    return  res.json({err:err});
                }            
                else{
                    emails.forEach(function(email){                    
                        sender.sendTemplate(email);                       
                    });
                    return  res.json({state:'send started'});
                }
                    
            });            
        });        
    }
    else{
        
    }
    queue_callback();
/*
var mailOptions = {
    from: '"Fred Foo 👥" <ivan@kv.skolka.ru>', // sender address
    to: 'ivan@eleview.com', // list of receivers
    subject: 'Hello ✔', // Subject line
    text: 'Hello world 🐴', // plaintext body
    html: '<b>Hello world 🐴</b>' // html body
};


// send mail with defined transport object
transporter.sendMail(mailOptions, function(error, info){
    if(error){
        console.log(error);
    }
    else{
        
    }
    console.log(info);
    console.log('Message sent: ' + info.response);
});
*/
    
}, 2/*concurrency!*/);

module.exports.queue = q;
module.exports.send = function(mail){
    mail.type="plain";
    q.push(mail, function (err) {
        if(err)
            console.log(err);
    });   
}

module.exports.sendTemplate = function(mail){
    mail.type="template";
    q.push(mail, function (err) {
        if(err)
            console.log(err);
    });       
}

