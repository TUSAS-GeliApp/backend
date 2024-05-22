const Router = require("express-promise-router");
const bcrypt = require("bcrypt");
const db = require("../db");
const router = new Router();
const MAX_LISTS = 20;
const {
  adminAuthMiddleware,
  authMiddleware,
} = require("../Middleware/security/authMiddlware");
const { uploadPP } = require("../Middleware/upload/uploadMiddleware");
const fs = require("fs");
const { sendEmail } = require("../Middleware/mail/sendMail");
module.exports = router;



// Get all users list
router.get("/lists", authMiddleware, async (req, res) => {
    const { rows } = await db.query(
      "SELECT * FROM users ORDER BY user_id",
      []
    );
    res.status(200).json(rows);
  });

  //get user info
  router.get("/user", authMiddleware, async (req, res) => {
    const { user_id } = req.tokenPayload;
    if (user_id === undefined) {
      return res.status(403).json({ message: "Invalid token" });
    }
    const { rows } = await db.query(
      "SELECT * FROM users WHERE user_id = $1",
      [user_id]
    );
    res.status(200).json(rows[0]);
  });

//request password reset - otpcode
router.post("/request-password-reset", async (req, res) => {
    try {
      const { email } = req.body;
      const { rows } = await db.query(
        "SELECT * FROM users WHERE email = $1",
        [email]
      );
      if (rows.length > 0) {
        const user = rows[0];
        await db.query("DELETE FROM otpcode WHERE user_id = $1", [user.user_id]);
        const otp = `${Math.floor(1000 + Math.random() * 9000)}`;
        const expiresTime = 120000;
        const expiresAt = new Date(Date.now() + expiresTime);
  
        const hashedOtp = await bcrypt.hash(otp, 10);
        await db.query(
          "INSERT INTO otpCode (user_id, otp, expiresAt) VALUES ($1::INTEGER, $2::VARCHAR, $3::TIMESTAMP)",
          [user.user_id, hashedOtp, expiresAt]
        );
  
        const subject = "Tusas Resend Password Reset";
        const text = `<p>Hi <b>${rows[0].name}</b>! Enter <b>${otp}</b> in the app to reset your password.</p>
        <p>This code <b>expires in 2 minutes</b>.</p>
        
        <p>If you did not request this, please ignore this email.</p>`;
        sendEmail(email, text, subject, res);
        res.status(200).json({
          message: "OTP Code was sent successfully to given email.",
        });
      } else {
        res
          .status(403)
          .json({ message: "There is no user with that email address." });
      }
    } catch (err) {
      console.error(err);
      res
        .status(500)
        .json({ message: "An error occurred while sending otp code." });
    }
  });
  

//forget password
router.post("/reset-password", async (req, res) => {
    const { email, otpCode, newPassword } = req.body;
  
    try {
      const { rows } = await db.query(
        "SELECT user_id FROM users WHERE email = $1",
        [email]
      );
      if (rows.length > 0) {
        const user_id = rows[0].user_id;
        let otpResult = await db.query(
          "SELECT * FROM otpcode WHERE user_id = $1",
          [user_id]
         

        );
        otpResult = otpResult.rows;
        if (otpResult.length > 0) {
          const { otp, expiresat } = otpResult[0];
          const isOTPMatched = await bcrypt.compare(otpCode.toString(), otp);
          if (isOTPMatched) {
            console.log(4);
            if (expiresat > Date.now()) {
              const hashedPassword = await bcrypt.hash(newPassword, 10);
              await db.query(
                "UPDATE users SET password = $1::VARCHAR WHERE user_id = $2::INTEGER",
                [hashedPassword, user_id],
                user_id,
                
              );
              await db.query("DELETE FROM otpcode WHERE user_id = $1", [user_id]);
              res.status(200).json({ message: "Password changed successfully." });
            } else {
              res
                .status(401)
                .json({ message: "Code has expired. Please try again." });
            }
          } else {
            res.status(401).json({ message: "Invalid code. Check your inbox." });
          }
        } else {res.status(401).json({ message: "Password reset request not found." });
    }
  } else {
    res.status(403).json({ message: "There is no user with that email." });
  }
} catch (err) {
  console.log(err);
  res
    .status(500)
    .json({ message: "An error occurred while reseting password." });
}
});


// Get user's all lists
router.get("/all_list", authMiddleware, async (req, res) => {
    const { user_id } = req.tokenPayload;
    if (user_id === undefined) {
      return res.status(403).json({ message: "Invalid Token" });
    }
    const { rows } = await db.query(
      "SELECT * FROM users WHERE user_id = $1::INTEGER",
      [user_id]
    );
    res.status(200).json(rows);
  });
  
// Get user information for admin
router.get("/:id", adminAuthMiddleware, async (req, res) => {
    const { id } = req.params;
    const { rows } = await db.query(
      "SELECT * FROM users WHERE user_id = $1",
      [id]
    );
    res.status(200).json(rows[0]);
  });


  // Add new user
router.post("/", adminAuthMiddleware, async (req, res) => {
    const { admin_id } = req.tokenPayload;
    
    const {
      name,
      surname,
      email,
      password,
      phone,
      job,
      is_banned,
      is_tusas,
      location,
      instagram,
      twitter,
      linkedin,
      facebook,
      
    } = req.body;
    try {
      // Check if user with the given id_number already exists
      const { rows: existingRows } = await db.query(
        "SELECT user_id FROM users WHERE email = $1",
        [ email]
      );
  
      if (existingRows.length > 0) {
        // User already exists, return their user_id
        res.status(409).json({
          user_id: existingRows[0].user_id,
          error: "User already exists.",
        });
      } else {
        const hashedPassword = await bcrypt.hash(password, 10);
        const { rows } = await db.query(
          "INSERT INTO users(name, surname, email, password,  phone, job, is_banned,  is_tusas, location, instagram,twitter,linkedin,facebook) values($1::VARCHAR, $2::VARCHAR, $3::VARCHAR, $4::VARCHAR, $5::VARCHAR, $6::VARCHAR, $7::BOOLEAN, $8::BOOLEAN, $9::VARCHAR, $10::VARCHAR, $11::VARCHAR, $12::VARCHAR, $13::VARCHAR)",
          [
            name,
            surname,
            email,
            hashedPassword,
            phone,
            job,
            is_banned,
            is_tusas,
            location,
            instagram,
            twitter,
            linkedin,
            facebook,

          ],
          admin_id,
          true
        );
        
        res.status(200).json({  message: "The user added succesfully." });
        console.log(1);
      }
    } catch (err) {
      console.error(err);
      res
        .status(500)
        .json({ error: "An error occurred while adding the user account." });
    }
  });
  
  // Update user information
  router.patch("/", authMiddleware, async (req, res) => {
    const { user_id } = req.tokenPayload;
    const { name, surname, email, job, phone , location, instagram,twitter,linkedin,facebook} =
      req.body;
    if (user_id === undefined) {
      return res.status(403).json({ message: "Invalid Token" });
    }
    try {
      await db.query(
        "UPDATE users SET name = ($1::VARCHAR), surname= ($2::VARCHAR),email= ($3::VARCHAR),job= ($4::VARCHAR),phone= ($5::VARCHAR),location= ($6::VARCHAR),instagram= ($7::VARCHAR),twitter= ($8::VARCHAR),linkedin= ($9::VARCHAR),facebook= ($10::VARCHAR) WHERE user_id = ($11::INTEGER)",
        [
            name, 
            surname, 
            email, 
            job, 
            phone,
            location, instagram,twitter,linkedin,facebook, user_id,
        ],
        user_id,
        false
      );
      res.status(200).json({ result: "User information updated successfully." });
    } catch (err) {
      console.error(err);
      res
        .status(500)
        .json({ error: "An error occurred while updating the user." });
    }
  });
  
  // Delete user
  router.delete("/:id", adminAuthMiddleware, async (req, res) => {
    const { id } = req.params;
    try {
      await db.query(
        "DELETE from users where user_id =($1::INTEGER)",
        [id],
        req.tokenPayload.admin_id,
        true
      );
      res.status(200).json({ result: "User deleted successfully." });
    } catch (err) {
      console.error(err);
      res
        .status(500)
        .json({ error: "An error occurred while deleting the user." });
    }
    res.status(409).json("User has book.");
  });
  
