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

// Get all podcast
router.get("/all_podcasts", authMiddleware, async (req, res) => {
    const { rows } = await db.query("SELECT * FROM podcasts");
    res.status(200).json(rows);
  });

// Add new podcast admin olcak
router.post("/add_podcast", adminAuthMiddleware, async (req, res) => {
    const { content, title , file_path , author_name} = req.body;
    try{
      const { rows } = await db.query(
        "SELECT 1 FROM podcasts WHERE title = $1",
        [title]
      );
     

      if (rows[0]) {
        res.status(409).json({
          error: `The podcast with the given name already exists`,
        });
      } else {
        

        await db.query(
          "Insert  into  podcasts(content, title , file_path , author_name) values($1::VARCHAR, $2::VARCHAR, $3::VARCHAR, $4::VARCHAR)",
          [content, title , file_path , author_name],
          req.tokenPayload.admin_id,
          true
        );
        res
          .status(200)
          .json("The podcast with the given name was added successfully.");
      }
    }
    catch {
        (err) => {
          console.error(err);
          res
            .status(500)
            .json({ error: "An error occurred while adding the podcast." });
        };
      }
  });

  // delete podcast  admin olcak
  router.delete("/:id", adminAuthMiddleware, async (req, res) => {
    const { id } = req.params;
    try {
      await db.query(
        "DELETE FROM podcasts WHERE podcast_id=($1::INTEGER)",
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
          .json({ error: "An error occurred while deleting the podcast." });
      };
    }
    
  });

  //update podcast  admin olcak
  router.patch("/:id/podcast", adminAuthMiddleware, async (req, res) => {
    const { id } = req.params;
    const { title } = req.body;
    const { content } = req.body;
    const {file_path} =req.body;
    const {author_name} = req.body;
    const { admin_id } = req.tokenPayload;
    if (admin_id === undefined) {
      return res.status(404).json({ message: "Invalid Token" });
    }
    try {
      await db.query(
        "UPDATE podcasts SET title = ($1::VARCHAR), content= ($2::VARCHAR),file_path = ($3::VARCHAR),author_name = ($4::VARCHAR) WHERE podcast_id = ($5::INTEGER);",
        [title, content ,file_path , author_name, id,],
        admin_id,
        false
      );
      res.status(200).json("podcast was upgraded successfully.");
    } catch {
      (err) => {
        console.error(err);
        res.status(500).json("An error occurred while upgrading the podcast.");
      };
    }
  });
