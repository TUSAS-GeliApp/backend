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

// Get all program
router.get("/all_program", authMiddleware, async (req, res) => {
    const { rows } = await db.query("SELECT * FROM program");
    res.status(200).json(rows);
  });

// Add new program 
router.post("/add_program", adminAuthMiddleware, async (req, res) => {
    const { content, name , image_path } = req.body;
    try{
      const { rows } = await db.query(
        "SELECT 1 FROM program WHERE name = $1",
        [name]
      );
     

      if (rows[0]) {
        res.status(409).json({
          error: `The program with the given name already exists`,
        });
      } else {
        

        await db.query(
          "Insert  into  program(content, name , image_path ) values($1::VARCHAR, $2::VARCHAR, $3::VARCHAR)",
          [content, name  , image_path],
          req.tokenPayload.admin_id,
          true
        );
        res
          .status(200)
          .json("The program with the given name was added successfully.");
      }
    }
    catch {
        (err) => {
          console.error(err);
          res
            .status(500)
            .json({ error: "An error occurred while adding the program." });
        };
      }
  });

  // delete program  
  router.delete("/:id", adminAuthMiddleware, async (req, res) => {
    const { id } = req.params;
    try {
      await db.query(
        "DELETE FROM program WHERE program_id=($1::INTEGER)",
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
          .json({ error: "An error occurred while deleting the program." });
      };
    }
    
  });

  //update program  
  router.patch("/:id/program", adminAuthMiddleware, async (req, res) => {
    const { id } = req.params;
    const { name } = req.body;
    const { content } = req.body;
    const {image_path} =req.body;
    const { admin_id } = req.tokenPayload;
    if (admin_id === undefined) {
      return res.status(404).json({ message: "Invalid Token" });
    }
    try {
      await db.query(
        "UPDATE program SET name = ($1::VARCHAR), content= ($2::VARCHAR),image_path = ($3::VARCHAR) WHERE program_id = ($4::INTEGER);",
        [name, content ,image_path , id,],
        admin_id,
        false
      );
      res.status(200).json("program was upgraded successfully.");
    } catch {
      (err) => {
        console.error(err);
        res.status(500).json("An error occurred while upgrading the program.");
      };
    }
  });
