const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const db = require("../config/db");

// Registro de usuario
exports.register = (req, res) => {
  const { username, password, email } = req.body;

  // Validar datos
  if (!username || !password || !email) {
    return res.status(400).json({ message: "Todos los campos son obligatorios" });
  }

  // Cifrar la contraseña
  const salt = bcrypt.genSaltSync(10);
  const hashedPassword = bcrypt.hashSync(password, salt);

  // Insertar en la base de datos
  const sql = "INSERT INTO users (username, password, email) VALUES (?, ?, ?)";
  db.query(sql, [username, hashedPassword, email], (err, result) => {
    if (err) {
      console.error(err);
      return res.status(500).json({ message: "Error en el servidor", error: err });
    }
    return res.status(201).json({ message: "Usuario registrado exitosamente" });
  });
};


// Inicio de sesión
exports.login = (req, res) => {
  const { username, password } = req.body;

  // Validar datos
  if (!username || !password) {
    return res.status(400).json({ message: "Todos los campos son obligatorios" });
  }

  // Verificar el usuario en la base de datos
  const sql = "SELECT * FROM users WHERE username = ?";
  db.query(sql, [username], (err, results) => {
    if (err) return res.status(500).json({ message: "Error en el servidor", error: err });
    if (results.length === 0) {
      return res.status(401).json({ message: "Credenciales inválidas" });
    }

    const user = results[0];
    const isPasswordValid = bcrypt.compareSync(password, user.password);

    if (!isPasswordValid) {
      return res.status(401).json({ message: "Credenciales inválidas" });
    }

    // Generar un token JWT
    const token = jwt.sign({ id: user.id, username: user.username }, process.env.JWT_SECRET, {
      expiresIn: "1d",
    });

    return res.status(200).json({ message: "Inicio de sesión exitoso", token });
  });
};
