const express = require('express')

const app = express()
var port = process.env.PORT || 3000;

// set the view engine to ejs
app.set('view engine', 'ejs');

app.get('/', (req, res) => {
  res.render('index');
})

const parts = require('./controllers/parts');
app.get('/getParts', (req, res) => {
  parts.getAll((list) => {
    res.render('parts.ejs', { all: list });
  });
})

app.get('/warehouseHomepage', (req, res) => {
  res.render('warehouseHomepage.ejs');
})

app.post('/workstation', (req, res) => {
  res.render('workstation.ejs');
})

app.post('/receivingDesk', (req, res) => {
  res.render('receivingDesk.ejs');
})

const credit = require('./controllers/credit');
app.get('/processCC', (req, res) => {
  credit.processSample((result) => {
    res.render('credit.ejs', { data: result });
  });
})

app.listen(port, () => {
  console.log(`Express server listening at http://localhost:${port}`)
})
