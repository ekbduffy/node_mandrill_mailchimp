var config = require('../config.js');
var mysql = require('../db.js');
var Cacheman = require('cacheman');
var cache = new Cacheman({ ttl: 1000 });
var mailchimp = require('mailchimp-v3');

var router = require("express").Router();



mailchimp.setApiKey(config.api.mailchimpkey);


router.get('/',function(req,res){
   campaignList(req,res); 
});
router.get('/new',function(req,res){
   createCampaignForm(null,req,res); 
});
router.post('/new',function(req,res){
    createCampaign(req,res);
});
router.get('/load',function(req,res){
   loadForm(null,req,res); 
});
router.post('/load',function(req,res){
    loadCampaign(req,res);
});
router.get('/details/:id',function(req,res){
   campaignDetails(req,res); 
});
router.post('/details/:id',function(req,res){
    campaignSave(req,res);
});


        
module.exports = router;

 function loadCampaign(req, res) {
     console.log(req.body);
     if(req.body.mailchimp && req.body.mailchimp != '')
     {
        mailchimp
        .get('campaigns/'+req.body.mailchimp)
        .then(function(MCcampaign){        
            mailchimp
            .get('campaigns/'+req.body.mailchimp+'/content')
            .then(function(MCcampaign_content){
                mysql.getConnection(function(err,db){
                    if(err)
                        console.log(err);
                    db.insert('campaign',{'name':req.body.name,'enname':req.body.enname,'mailchimpid':req.body.mailchimp,'sender':req.body.sender,'html':MCcampaign_content.html,'plaintext':MCcampaign_content.plain_text,'subject':MCcampaign.settings.subject_line},function(err, recordId){
                        db.release();
                        if(err)
                        {
                            console.log(err.message);
                            return loadForm(err.message,req,res)
                        }
                        else{
                            return res.redirect('/campaign/details/'+recordId);}
                    });
                });		                
                
            
            })
            .catch(function(error){
                console.log(error.message);
                loadForm(error.message,req,res)
            });            
        })
        .catch(function(error){
            console.log(error.message);
            loadForm(error.message,req,res)
        });         
     }
     else{
        loadForm('Необходимо выбрать шаблон',req,res)
     }      
 } 

function loadForm(err,req,res){     
    mysql.getConnection(function(error,db){
        if(error)
            console.log(error);	
        db.query('SELECT * FROM sender',function(error, senderResult){
            db.release();
            if(error){
                err = error.message;
                return  res.render('campaigns/load',{req:req,err:err,campaigns:data.campaigns,sender:senderResult});
            }
            
            cache.wrap('mailchimpCampaigns', function(callback){
                mailchimp
                .get('campaigns',{fields:['id','settings']})
                .then(function(data){
                        callback(null,data);                                
                })
                .catch(function(error){
                    console.log(error.message);
                    return  res.render('campaigns/load',{req:req,err:error.message,campaigns:data,sender:senderResult});
                });           
            }, '1000s', function (error, data) {
                if(error){
                    console.log(err);
                    err = error.message;
                }
                return  res.render('campaigns/load',{req:req,err:err,campaigns:data.campaigns,sender:senderResult});
            });
        });
    });        
}

function createCampaignForm(err,req,res){
    mysql.getConnection(function(error,db){
        if(error)
            console.log(error);	
        db.query('SELECT * FROM sender',function(error, senderResult){
            db.release();
            if(error){
                err = error.message;

            }            
                return  res.render('campaigns/create',{req:req,err:err,sender:senderResult});
        });
    });    
}

function campaignList(req,res){
    var err = null;
    mysql.getConnection(function(error,db){
        if(error)
            console.log(error);	
        db.query('SELECT campaign.id,campaign.name,campaign.enname,sender.name AS sendername,campaign.created FROM campaign LEFT JOIN sender ON (sender.id = campaign.sender)',function(error, list){
            db.release();
            if(error){
                err = error.message;
            }            
                return  res.render('campaigns/list',{req:req,err:err,campaigns:list});
        });
    });        
}

function campaignDetails(req,res){
    var err = null;
    mysql.getConnection(function(error,db){
        if(error)
            console.log(error);	
        db.queryRow('SELECT campaign.*,sender.id AS senderid FROM campaign LEFT JOIN sender ON (sender.id = campaign.sender) where campaign.id=?', [req.params.id],function(error, campaign){
            if(error){
                err = error.message;
            }              
            db.query('SELECT * FROM sender',function(error, senders){            
                if(error){
                    err = error.message;
                }            
                return  res.render('campaigns/details',{req:req,err:err,campaign:campaign,senders:senders});
            });
        });
    });    
}


function campaignSaveDetails(req,res){
    var err = null;
    mysql.getConnection(function(error,db){
        if(error)
            console.log(error);	
        db.update('campaign', {'name':req.body.name,'enname':req.body.enname,'sender':req.body.sender,'html':req.body.html,'plaintext':req.body.plaintext,'subject':req.body.subject},{id:req.params.id},function(error){
            if(error){
                err = error.message;
            }              
            db.query('SELECT * FROM sender',function(error, senders){            
                if(error){
                    err = error.message;
                }            
                return  res.render('campaigns/details',{req:req,err:err,campaign:campaign,senders:senders});
            });
        });
    });    
}