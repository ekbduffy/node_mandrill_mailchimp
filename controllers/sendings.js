var config = require('../config.js');
var mysql = require('../db.js');
var Cacheman = require('cacheman');
var cache = new Cacheman({ ttl: 1000 });

var router = require("express").Router();
var sender = require('../sender.js');




router.get('/',function(req,res){
   sendingsList(req,res); 
});

router.get('/new',function(req,res){
   createSendingForm(null,req,res); 
});

router.post('/new',function(req,res){
    createSending(req,res);
});
router.get('/run/:id',function(req,res){
    Send(req,res);
});

router.get('/details/:id',function(req,res){
   sendingDetails(req,res); 
});
router.post('/details/:id',function(req,res){
    sendingSave(req,res);
});


module.exports = router;

function sendingsList(req,res){
    var err = null;
    mysql.getConnection(function(error,db){
        if(error)
            console.log(error);	
        db.query('SELECT sending.id,sending.created,camp.enname,li.name AS liname,exli.name AS exliname FROM sending LEFT JOIN LIST li ON (li.id = sending.list) LEFT JOIN LIST exli ON (exli.id = sending.excludeList) LEFT JOIN campaign camp ON (camp.id = sending.campaign)',function(error, list){
            db.release();
            if(error){
                err = error.message;
            }            
                return  res.render('sendings/list',{req:req,err:err,sendings:list});
        });
    });        
}

function sendingDetails(req,res){
    var err = null;
    mysql.getConnection(function(error,db){
        if(error)
            console.log(error);	
        db.queryRow('SELECT s.*,s.created,camp.enname,li.name AS liname,exli.name AS exliname, (SELECT COUNT(*) FROM sendingdata WHERE sendingID = s.id)  AS datanum, (SELECT COUNT(*) FROM listemails WHERE listid = li.id)  AS listnum FROM sending s LEFT JOIN LIST li ON (li.id = s.list) LEFT JOIN LIST exli ON (exli.id = s.excludeList) LEFT JOIN campaign camp ON (camp.id = s.campaign) WHERE s.id =?', [req.params.id],function(error, sending){
            db.release();
            if(error){
                err = error.message;
            }            
                return  res.render('sendings/details',{req:req,err:err,sending:sending});
        });
    });        
}


function Send(req,res){
    mysql.getConnection(function(error,db){
        if(error){
            console.log(error);
            return  res.json({err:error.message});
        }
            
        db.query('SELECT l.*, s.campaign FROM sending s LEFT JOIN listemails l ON (l.listid = s.list) WHERE s.id =?  AND l.subscribed = 1 AND l.email NOT IN (SELECT email FROM listemails WHERE listid = s.excludeList)', [req.params.id],function(error, emails){            
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