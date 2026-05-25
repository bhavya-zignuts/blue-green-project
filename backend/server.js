// const express = require('express');
// const app = express();

// const VERSION = process.env.VERSION || 'v1';
// const ENVIRONMENT = process.env.ENVIRONMENT || 'blue';

// app.get('/', (req, res) => {
//     res.send({
//         message: 'Hello From Backend',
//         version: VERSION,
//         environment: ENVIRONMENT
//     });
// });

// app.get('/health', (req, res) => {
//     res.status(200).send('Backend Healthy');
// });

// app.listen(5000, () => {
//     console.log('Backend Running on Port 5000');
// });
const express = require('express')

const app = express()

const PORT = 5000

app.get('/', (req, res) => {
    res.send('Hello From Backend V1')
})

app.get('/health', (req, res) => {
    res.send('OK')
})

app.listen(PORT, () => {
    console.log(`Backend running on ${PORT}`)
})