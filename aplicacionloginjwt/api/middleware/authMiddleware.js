const jwt = require("jsonwebtoken");

exports.verifyToken = (req, res, next) => {
  const token = req.headers["authorization"];

  if (!token) {
    return res.status(403).json({ message: "Token no proporcionado" });
  }

  try {
    const decoded = jwt.verify(token.split(" ")[1], process.env.JWT_SECRET); // Extraer el token
    req.user = decoded; // Guardar los datos del usuario en la solicitud
    next();
  } catch (err) {
    return res.status(401).json({ message: "Token inválido", error: err.message });
  }
};
