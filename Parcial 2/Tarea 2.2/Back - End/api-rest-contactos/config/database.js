const mongoose = require('mongoose');
require('dotenv').config();  // Asegúrate de que dotenv esté configurado

const connectDB = async () => {
  try {
    await mongoose.connect(process.env.MONGO_URI);  // Sin las opciones deprecated
    console.log("MongoDB conectado exitosamente");
  } catch (error) {
    console.error("Error al conectar a MongoDB:", error.message);
    process.exit(1);
  }
};

module.exports = connectDB;
