const Router = require("express-promise-router");
const db = require("../db");
const router = new Router();
const { adminAuthMiddleware } = require("../Middleware/security/authMiddlware");

module.exports = router;

// Ban an user
router.post("/:id", adminAuthMiddleware, async (req, res) => {
  const { id } = req.params;
 
  try {
    // Check if user with the given id_number is already banned
    const { rows } = await db.query(
      "SELECT is_banned FROM users WHERE user_id = $1",
      [id]
    );

    if (rows[0].banned) {
      // User is already banned
      res.status(409).json({
        error: "User is already banned.",
      });
    } else {
      await db.query(
        "UPDATE users  SET is_banned = ($1::BOOLEAN) where user_id = ($2::INTEGER) ",
            [true,id],
        
      );
      res.status(200).json({ user_id: id });
    }
  } catch (err) {
    console.error(err);
    res
      .status(500)
      .json({ error: "An error occurred while banning the user." });
  }
});

// Unban an user
router.patch("/:id/unban", adminAuthMiddleware, async (req, res) => {
  const { id } = req.params;
  try {
    // Check if user with the given id_number is banned
    const { rows } = await db.query(
      "SELECT is_banned FROM users WHERE user_id = $1",
      [id]
    );
    console.log(rows[0]);
    if (rows[0].is_banned) {
        await db.query(
            "UPDATE users  SET is_banned = ($1::BOOLEAN) where user_id = ($2::INTEGER) ",
            [false,id],
            
          );
      res.status(200).json({ user_id: id });
    } else {
      // User is not banned
      res.status(409).json({
        error: "User is not banned.",
      });
    }
  } catch (err) {
    console.error(err);
    res
      .status(500)
      .json({ error: "An error occurred while unbanning the user." });
  }
});

// Get all banned users
router.get("/", adminAuthMiddleware, async (req, res) => {
  const { rows } = await db.query(
    "SELECT * FROM users WHERE is_banned = true ORDER BY user_id"
  );
  res.status(200).json(rows);
});
