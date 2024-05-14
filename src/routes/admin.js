const Router = require("express-promise-router");
const db = require("../db");
const router = new Router();
const bcrypt = require("bcrypt");
const {
  adminAuthMiddleware,
  adminAndLoggedAuthMiddleware,
} = require("../Middleware/security/authMiddlware");

module.exports = router;

// Get all admins information
router.get("/", adminAuthMiddleware, async (req, res) => {
  const { rows } = await db.query("SELECT * FROM admin");
  res.status(200).json(rows);
});

// Add new admin
router.post("/", adminAuthMiddleware, async (req, res) => {
  const { name, surname, email, password } =
    req.body;
  try {
    // Check if admin with the given email already exists
    const { rows: existingRows } = await db.query(
      "SELECT email FROM admin WHERE email = $1::VARCHAR",
      [email]
    );

    if (existingRows.length > 0) {
      // Admin already exists, return their admin name
      res.status(409).json({
        admin_id: existingRows[0].admin_id,
        error: "Admin already exists.",
      });
    } else {
      const hashedPassword = await bcrypt.hash(password, 10);
      const { rows } = await db.query(
        "INSERT INTO admin(name,surname,email,password) values($1::VARCHAR, $2::VARCHAR, $3::VARCHAR, $4::VARCHAR)",
        [
          name,
          surname,
          email,
          hashedPassword,
        ],
        req.tokenPayload.admin_id,
        true
      );
      res.status(200).json({ admin_id: rows[0].p_admin_id });
    }
  } catch (err) {
    console.error(err);
    res
      .status(500)
      .json({ error: "An error occurred while adding the admin." });
  }
});

// Update admin information
router.patch("/", adminAndLoggedAuthMiddleware, async (req, res) => {
  const { admin_id } = req.tokenPayload;
  const { name, surname, email } = req.body;
  try {
    await db.query(
      "UPDATE admin SET name =($1::VARCHAR),surname =($1::VARCHAR),email =($1::VARCHAR) WHERE admin_id =($1::INTEGER) )",
      [name, surname, email,admin_id ],
      req.tokenPayload.admin_id,
      true
    );
    res.status(200).json({ result: "Admin information updated successfully." });
  } catch (err) {
    console.error(err);
    res
      .status(500)
      .json({ error: "An error occurred while updating the admin." });
  }
});
