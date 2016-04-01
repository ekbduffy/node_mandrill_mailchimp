var config = require('../config.js');
var mysql = require('../db.js');
var Cacheman = require('cacheman');
var cache = new Cacheman({ ttl: 1000 });

var router = require("express").Router();


router.get('/',function(req,res){
   sendingsList(req,res); 
});

router.get('/new',function(req,res){
   createSendingForm(null,req,res); 
});

router.post('/new',function(req,res){
    createSending(req,res);
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
        db.queryRow('SELECT sending.*,sending.created,camp.enname,li.name AS liname,exli.name AS exliname FROM sending LEFT JOIN LIST li ON (li.id = sending.list) LEFT JOIN LIST exli ON (exli.id = sending.excludeList) LEFT JOIN campaign camp ON (camp.id = sending.campaign) where sending.id =?', [req.params.id],function(error, sending){
            db.release();
            if(error){
                err = error.message;
            }            
                return  res.render('sendings/details',{req:req,err:err,sending:sending});
        });
    });        
}