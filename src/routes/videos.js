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

// Get all video
router.get("/all_videos", authMiddleware, async (req, res) => {
    const { rows } = await db.query("SELECT * FROM videos");
    res.status(200).json(rows);
  });

// Add new video admin olcak
router.post("/add_video", adminAuthMiddleware, async (req, res) => {
    const {  title , videos_path,} = req.body;
    try{
      const { rows } = await db.query(
        "SELECT 1 FROM videos WHERE title = $1",
        [title]
      );
     

      if (rows[0]) {
        res.status(409).json({
          error: `The video with the given name already exists`,
        });
      } else {
        

        await db.query(
          "Insert  into  videos( title , videos_path ) values($1::VARCHAR, $2::VARCHAR)",
          [ title , videos_path ],
          req.tokenPayload.admin_id,
          true
        );
        res
          .status(200)
          .json("The video with the given name was added successfully.");
      }
    }
    catch {
        (err) => {
          console.error(err);
          res
            .status(500)
            .json({ error: "An error occurred while adding the video." });
        };
      }
  });

  // delete video  admin olcak
  router.delete("/:id", adminAuthMiddleware, async (req, res) => {
    const { id } = req.params;
    try {
      await db.query(
        "DELETE FROM videos WHERE videos_id=($1::INTEGER)",
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
          .json({ error: "An error occurred while deleting the video." });
      };
    }
    
  });

  //update video  admin olcak
  router.patch("/:id/video", adminAuthMiddleware, async (req, res) => {
    const { id } = req.params;
    const { title } = req.body;
    const {videos_path} =req.body;
    const { admin_id } = req.tokenPayload;
    if (admin_id === undefined) {
      return res.status(404).json({ message: "Invalid Token" });
    }
    try {
      await db.query(
        "UPDATE videos SET title = ($1::VARCHAR), videos_path = ($3::VARCHAR) WHERE video_id = ($3::INTEGER);",
        [title, videos_path, id,],
        admin_id,
        false
      );
      res.status(200).json("video was upgraded successfully.");
    } catch {
      (err) => {
        console.error(err);
        res.status(500).json("An error occurred while upgrading the video.");
      };
    }
  });
