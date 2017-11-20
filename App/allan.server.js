console.log('<<<<<<<<<<<<<<<<<<<<')
console.log('Starting the rolê')
var express = require('express');
console.log(express)
var path = require('path');
var serveStatic = require('serve-static');
app = express();
app.use(serveStatic(__dirname + "/dist"));
var port = process.env.PORT || 5000;
app.listen(port);
console.log('server started '+ port);