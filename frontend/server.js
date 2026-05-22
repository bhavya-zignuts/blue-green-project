const express = require('express');
const app = express();

const VERSION = process.env.VERSION || 'v1';
const ENVIRONMENT = process.env.ENVIRONMENT || 'blue';

app.get('/', (req, res) => {
    res.send(`
        <h1>Hello From Frontend</h1>
        <h2>Version: ${VERSION}</h2>
        <h2>Environment: ${ENVIRONMENT}</h2>
    `);
});

app.get('/health', (req, res) => {
    res.status(200).send('Frontend Healthy');
});

app.listen(3000, () => {
    console.log('Frontend Running on Port 3000');
});