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

// add event to calender
router.post("/:id/event", authMiddleware, async (req, res) => {
    const {name,date } = req.body;
    const { id } = req.params;
    try{
      const { rows } = await db.query(
        "SELECT 1 FROM calender_event WHERE name = $1",
        [name]
      );
     

      if (rows[0]) {
        res.status(409).json({
          error: `The event already added the calender`,
        });
      } else {

        await db.query(
          "Insert  into  calender_event(event_id,name ,date) values($1::INTEGER ,$2::VARCHAR, $3::VARCHAR)",
          [id,name, date],
        );
        res
          .status(200)
          .json("The event added the calender succesfully.");
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

//add program to calender
  router.post("/:id/program", authMiddleware, async (req, res) => {
    const {name,date } = req.body;
    const { id } = req.params;
   // try{
      const { rows } = await db.query(
        "SELECT 1 FROM calender_program WHERE name = $1",
        [name]
      );
     
      console.log(rows[0])
      if (rows[0]) {
        res.status(409).json({
          error: `The program already added the calender`,
        });
      } else {

        await db.query(
          "Insert  into  calender_program(program_id,name ,date) values($1::INTEGER ,$2::VARCHAR, $3::VARCHAR)",
          [id,name, date],
        );
        res
          .status(200)
          .json("The program added the calender succesfully.");
      }
    //}
    //catch{
    //    (err) => {
    //        console.error(err);
    //        res
    //          .status(500)
    //          .json({ error: "An error occurred while adding the user." });
    //      };
    //  }
  });

//delete program to calender
  router.delete("/:id/program", authMiddleware, async (req, res) => {
    const { id } = req.params;
    try {
      await db.query(
        "DELETE FROM calender_program WHERE program_id=($1::INTEGER)",
        [id],
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

  //delete event to calender
  router.delete("/:id/event", authMiddleware, async (req, res) => {
    const { id } = req.params;
    try {
      await db.query(
        "DELETE FROM calender_event WHERE event_id=($1::INTEGER)",
        [id],
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

// Get all program_calender
router.get("/all_program", authMiddleware, async (req, res) => {
    const { rows } = await db.query("SELECT * FROM calender_program");
    res.status(200).json(rows);
  });

  // Get all event_calender
router.get("/all_event", authMiddleware, async (req, res) => {
    const { rows } = await db.query("SELECT * FROM calender_event");
    res.status(200).json(rows);
  });
