const app = require('./app');

app.listen(app.get('port'), () => {
    console.log("esta en el puerto", app.get("port"));
});