const express = require('express');
const axios = require('axios');
const os = require('os');
const app = express();

const VERSION = '1.0.0';
const API_KEY = '5c8d077895726d3329dfdf973b6960ad';  // Ensure this is your actual OpenWeatherMap API key
const WEATHER_API_URL = `https://api.openweathermap.org/data/2.5/weather?q=Dhaka&units=metric&appid=${API_KEY}`;

app.get('/api/hello', async (req, res) => {
    try {
        const response = await axios.get(WEATHER_API_URL);
        const weather = response.data.main.temp;

        res.json({
            "hostname": "server1",
            "datetime": new Date().toISOString().replace(/[-:T]/g, '').slice(0, 12), // Correcting to YYMMDDHHmm format
            "version": VERSION,
            "weather": {
                "dhaka": {
                    "temperature": weather.toString(),
                    "temp_unit": "c"
                }
            }
        });
    } catch (error) {
        res.status(500).send('Error fetching weather data');
    }
});

app.get('/api/health', (req, res) => {
    res.json({ status: 'UP' });
});

const PORT = process.env.PORT || 3033;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
