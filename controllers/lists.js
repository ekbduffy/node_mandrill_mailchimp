var config = require('../config.js');
var mysql = require('../db.js');

var router = require("express").Router();



router.get('/',function(req,res){
   listList(req,res); 
});
router.get('/new',function(req,res){
   createListForm(null,req,res); 
});
router.post('/new',function(req,res){
   createList(req,res); 
});
router.get('/details/:id',function(req,res){
   listDetails(null,req,res); 
});
router.post('/details/:id',function(req,res){
   if(req.body.action == 'add'){
     listTryAdd(req,res);
   }
   else if(req.body.action == 'save'){
    listSaveDetails(req,res);    
   }
    
});



module.exports = router;


function listList(req,res){
    var err = null;
    mysql.getConnection(function(error,db){
        if(error)
            console.log(error);	
        db.query('SELECT list.*, COUNT(listemails.id) AS emails FROM LIST LEFT JOIN listemails ON (list.id = listemails.listID) GROUP BY list.id',function(error, list){
            db.release();
            if(error){
                err = error.message;
            }            
                return  res.render('lists/list',{req:req,err:err,lists:list});
        });
    });    
}

function listDetails(err,req,res){
    mysql.getConnection(function(error,db){
        if(error)
            console.log(error);	
        db.queryRow('SELECT list.*, COUNT(listemails.id) AS emails FROM LIST LEFT JOIN listemails ON (list.id = listemails.listID) GROUP BY list.id',function(error, list){
            if(error){
                err = error.message;
            }            
            db.select('listemails','*',{listid:req.params.id},{id:'asc'},function(error, listemails){
                            
                db.release();
                if(error){
                    err = error.message;
                }            
                return  res.render('lists/details',{req:req,err:err,list:list,emails:listemails});
            });
        });
    });        
}

function listTryAdd(req,res){
    console.log(req.body.type);

}