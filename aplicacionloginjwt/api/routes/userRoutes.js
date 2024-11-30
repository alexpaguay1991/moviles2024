const express = require("express");
const router = express.Router();
const bcrypt = require('bcryptjs');  // Importar bcrypt para manejar el hash de contraseñas
const { verifyToken } = require("../middleware/authMiddleware");
const db = require("../config/db");

// Obtener todos los usuarios (ruta protegida)
router.get("/users", verifyToken, (req, res) => {
  const sql = "SELECT id, username FROM users"; // No enviar contraseñas en las respuestas
  db.query(sql, (err, results) => {
    if (err) return res.status(500).json({ message: "Error en el servidor", error: err });
    return res.status(200).json({ users: results });
  });
});

// Obtener un usuario por ID (ruta protegida)
router.get("/users/:id", verifyToken, (req, res) => {
  const userId = req.params.id;
  const sql = "SELECT id, username FROM users WHERE id = ?";
  db.query(sql, [userId], (err, results) => {
    if (err) return res.status(500).json({ message: "Error en el servidor", error: err });
    if (results.length === 0) return res.status(404).json({ message: "Usuario no encontrado" });
    return res.status(200).json({ user: results[0] });
  });
});

// Actualizar un usuario por ID (ruta protegida)
router.put("/users/:id", verifyToken, (req, res) => {
  const userId = req.params.id;
  const { username, password } = req.body;
  
  // Si no se proporciona contraseña, no se realiza actualización de la misma
  const hashedPassword = password ? bcrypt.hashSync(password, 10) : null;
  
  const sql = "UPDATE users SET username = ?, password = ? WHERE id = ?";
  db.query(sql, [username, hashedPassword || undefined, userId], (err, result) => {
    if (err) return res.status(500).json({ message: "Error en el servidor", error: err });
    if (result.affectedRows === 0) return res.status(404).json({ message: "Usuario no encontrado" });
    return res.status(200).json({ message: "Usuario actualizado exitosamente" });
  });
});

// Eliminar un usuario por ID (ruta protegida)
router.delete("/users/:id", verifyToken, (req, res) => {
  const userId = req.params.id;
  const sql = "DELETE FROM users WHERE id = ?";
  db.query(sql, [userId], (err, result) => {
    if (err) return res.status(500).json({ message: "Error en el servidor", error: err });
    if (result.affectedRows === 0) return res.status(404).json({ message: "Usuario no encontrado" });
    return res.status(200).json({ message: "Usuario eliminado exitosamente" });
  });
});

module.exports = router;
