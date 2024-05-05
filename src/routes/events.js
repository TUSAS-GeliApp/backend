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

// Get all events
router.get("/all_events", authMiddleware, async (req, res) => {
    const { rows } = await db.query("SELECT * FROM events");
    res.status(200).json(rows);
  });

// Add new event admin olcak
router.post("/add_event", adminAuthMiddleware, async (req, res) => {
    const { content, name ,image_path } = req.body;
    try{
      const { rows } = await db.query(
        "SELECT 1 FROM events WHERE name = $1",
        [name]
      );
     

      if (rows[0]) {
        res.status(409).json({
          error: `The event with the given name already exists`,
        });
      } else {

        await db.query(
          "Insert  into  events(name ,content ,image_path) values($1::VARCHAR, $2::VARCHAR, $3::VARCHAR)",
          [name, content , image_path],
          req.tokenPayload.admin_id,
          true
        );
        res
          .status(200)
          .json("The event with the given name was added successfully.");
      }
    }
    catch {
        (err) => {
          console.error(err);
          res
            .status(500)
            .json({ error: "An error occurred while adding the event." });
        };
      }
  });

  // delete event  admin olcak
  router.delete("/:id", adminAuthMiddleware, async (req, res) => {
    const { id } = req.params;
    try {
      await db.query(
        "DELETE FROM events WHERE event_id=($1::INTEGER)",
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
          .json({ error: "An error occurred while deleting the event." });
      };
    }
    
  });

  //update event  admin olcak
  router.patch("/:id/event", adminAuthMiddleware, async (req, res) => {
    const { id } = req.params;
    const { name } = req.body;
    const { content } = req.body;
    const { admin_id } = req.tokenPayload;
    const { image_path} = req.body;
    if (admin_id === undefined) {
      return res.status(404).json({ message: "Invalid Token" });
    }
    try {
      await db.query(
        "UPDATE events SET name = ($1::VARCHAR), content= ($2::VARCHAR),image_path= ($3::VARCHAR) WHERE event_id = ($4::INTEGER);",
        [name, content, image_path, id ],
        admin_id,
        false
      );
      res.status(200).json("Event was upgraded successfully.");
    } catch {
      (err) => {
        console.error(err);
        res.status(500).json("An error occurred while upgrading the rate.");
      };
    }
  });
