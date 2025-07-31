var mysql = require('mysql')
var connection = mysql.createConnection({
  host: 'blitz.cs.niu.edu',
  user: 'student',
  password: 'student',
  database: 'csci467'
});

connection.connect();

module.exports = {
    getAll: async result => {
        connection.query('SELECT * FROM parts', function(err, rows){
            if (err) throw err;
            console.log('found ', rows.length , ' parts');
            result(rows);
        });
    }
}