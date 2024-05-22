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
    const { content, name , image_path,program_date,location,program_link,sss } = req.body;
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
          "Insert  into  program(content, name , image_path,program_date,location,program_link,sss ) values($1::VARCHAR, $2::VARCHAR, $3::VARCHAR, $4::VARCHAR, $5::VARCHAR, $6::VARCHAR, $7::VARCHAR)",
          [content, name  , image_path,program_date,location,program_link,sss],
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
    const {program_date} =req.body;
    const {location} =req.body;
    const {program_link} =req.body;
    const {sss} =req.body;
    const { admin_id } = req.tokenPayload;
    if (admin_id === undefined) {
      return res.status(404).json({ message: "Invalid Token" });
    }
    try {
      await db.query(
        "UPDATE program SET name = ($1::VARCHAR), content= ($2::VARCHAR),image_path = ($3::VARCHAR),program_date = ($4::VARCHAR),location = ($5::VARCHAR),program_link = ($6::VARCHAR),sss = ($7::VARCHAR) WHERE program_id = ($8::INTEGER);",
        [name, content ,image_path ,program_date,location,program_link,sss, id],
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


  // speaker
router.post("/:id/speaker", adminAuthMiddleware, async (req, res) => {
    const { id } = req.params;
    const { user_id } = req.body;
   
    try{
      const { rows } = await db.query(
        "SELECT * FROM program_speaker WHERE program_id = $1 and user_id = $2 ",
        [id , user_id]
      );

      if (rows[0]) {
        res.status(409).json({
          error: `User is already spekaer in this program`,
        });
      } else {

        await db.query(
          "Insert  into  program_speaker(program_id ,user_id ) values($1::INTEGER, $2::INTEGER)",
          [id, user_id  ],
          req.tokenPayload.user_id,
        );
        res
          .status(200)
          .json("User added this program's speaker list succesfully.");
      }

      }
      catch{
        (err) => {
            console.error(err);
            res
              .status(500)
              .json({ error: "An error occurred while adding the user." });
          };
      }
  });
