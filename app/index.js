const express = require('express');
const app = express();

app.get('/', (req, res) => {
    const timestamp = new Date().toISOString();
    const ip = req.headers['x-forwarded-for'] || req.socket.remoteAddress;
    res.json({ timestamp, ip})
});

const PORT = process.env.PORT || 3000;

app.listen(PORT, '0.0.0.0', () => {
    console.log(`simple-time-service running on port ${PORT}!`);
});