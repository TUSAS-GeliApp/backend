const Router = require("express-promise-router");
const db = require("../db");
const router = new Router();
const {
  adminAuthMiddleware,
  authMiddleware,
} = require("../Middleware/security/authMiddlware");
const {
  uploadPDF,
  uploadAudio,
  uploadVideo,
} = require("../Middleware/upload/uploadMiddleware");
const fs = require("fs");

module.exports = router;

// Get all newsletter
router.get("/all_newsletters", authMiddleware, async (req, res) => {
    const { rows } = await db.query("SELECT * FROM newsletters");
    res.status(200).json(rows);
  });

// Add new newsletter
router.post("/add_newsletter", adminAuthMiddleware, async (req, res) => {
    const { content, title , author_name} = req.body;
    try{
      const { rows } = await db.query(
        "SELECT 1 FROM newsletters WHERE title = $1",
        [title]
      );
     

      if (rows[0]) {
        res.status(409).json({
          error: `The newsletter with the given name already exists`,
        });
      } else {
        

        await db.query(
          "Insert  into  newsletters(content, title , author_name) values($1::VARCHAR, $2::VARCHAR, $3::VARCHAR)",
          [content, title  , author_name],
          req.tokenPayload.admin_id,
          true
        );
        res
          .status(200)
          .json("The newsletter with the given name was added successfully.");
      }
    }
    catch {
        (err) => {
          console.error(err);
          res
            .status(500)
            .json({ error: "An error occurred while adding the newsletter." });
        };
      }
  });

  // delete newsletter  
  router.delete("/:id", adminAuthMiddleware, async (req, res) => {
    const { id } = req.params;
    try {
    
      await db.query(
        "DELETE FROM newsletters WHERE newsletter_id=($1::INTEGER)",
        [id],
        req.tokenPayload.admin_id,
        true
      );
      res.status(200).json("The delete was successful.");
      
    } catch {
      (err) => {
        console.error(err);
        res
          .status(500)
          .json({ error: "An error occurred while deleting the newsletter." });
      };
    }
    
  });

  //update newsletter 
  router.patch("/:id/newsletter", adminAuthMiddleware, async (req, res) => {
    const { id } = req.params;
    const { title } = req.body;
    const { content } = req.body;
    const {author_name} = req.body;
    const { admin_id } = req.tokenPayload;
    if (admin_id === undefined) {
      return res.status(404).json({ message: "Invalid Token" });
    }
    try {
      await db.query(
        "UPDATE newsletters SET title = ($1::VARCHAR), content= ($2::VARCHAR),author_name = ($3::VARCHAR) WHERE newsletter_id = ($4::INTEGER);",
        [title, content , author_name, id,],
        admin_id,
        false
      );
      res.status(200).json("newsletter was upgraded successfully.");
          
    } catch {
      (err) => {
        console.error(err);
        res.status(500).json("An error occurred while upgrading the newsletter.");
      };
    }
  });
