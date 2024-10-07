const obtenerTipoCambioActual = async (req, res) => {
    try {
        require('dotenv').config();
        const fechaActual = new Date().toISOString().split('T')[0];
        const token = process.env.TOKEN_CAMBIO; 
        const { default: fetch } = await import('node-fetch');
        const apiUrl = `https://api.apis.net.pe/v2/sunat/tipo-cambio?date=${fechaActual}`;
        const response = await fetch(apiUrl, {
            headers: {
                'Authorization': `Bearer ${token}`
            }
        });
        if (!response.ok) {
            throw new Error('Error al obtener el tipo de cambio');
        }
        const data = await response.json();
        res.json(data);
    } catch (error) {
        console.error('Error:', error);
        res.status(500).json({ error: 'Error al obtener el tipo de cambio' });
    }
};

module.exports = { obtenerTipoCambioActual };