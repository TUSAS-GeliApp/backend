const jwt = require("jsonwebtoken");

const authMiddleware = (req, res, next) => {
  const token = req.headers["authorization"]?.split(" ")[1];
  if (!token) return res.status(401).json({ message: "Invalid token" });
  jwt.verify(token, process.env.ACCES_TOKEN_SECRET, (err, payload) => {
    if (err) {
      console.log(err);
      res.status(400).json({ message: err.message });
    }
    req.tokenPayload = payload;
    next();
  });
};

const adminAuthMiddleware = (req, res, next) => {
//  const token = req.headers["authorization"]?.split(" ")[1];
//  if (!token) return res.status(401).json({ message: "Invalid token" });
//  jwt.verify(token, process.env.ACCES_TOKEN_SECRET, (err, payload) => {
//    if (err) {
//      console.log(err);
//      res.status(400).json({ message: err.message });
//    }
//    if (payload.admin) {
//      req.tokenPayload = payload;
//      next();
//    } else {
//      res.status(403).json({ message: "The given user is not admin." });
//    }
//  });
next();
};

module.exports = {
  authMiddleware,
  adminAuthMiddleware,
};
