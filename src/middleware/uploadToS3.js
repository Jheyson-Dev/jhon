require('dotenv').config();
const { S3, PutObjectCommand } = require('@aws-sdk/client-s3');
const { v4: uuid } = require('uuid');

async function uploadToS3(file) {
    try {
        const s3Client = new S3({
            endpoint: process.env.S3_ENDPOINT,
            region: process.env.S3_REGION,
            credentials: {
                accessKeyId: process.env.S3_ACCESS_KEY_ID,
                secretAccessKey: process.env.S3_SECRET_ACCESS_KEY,
            },
        });

        const fileName = `${uuid()}.${file.originalname.split(".").pop()}`;
        const bucketParams = {
            Bucket: "deybiparts",
            Key: fileName,
            Body: file.buffer,
            ACL: "public-read",
        };

        const response = await s3Client.send(new PutObjectCommand(bucketParams));
        const imageUrl = `https://nyc3.digitaloceanspaces.com/deybiparts/${fileName}`;
        return imageUrl;
    } catch (error) {
        console.error('Error al subir la imagen:', error);
        throw new Error('Error al subir la imagen');
    }
}

module.exports = uploadToS3;