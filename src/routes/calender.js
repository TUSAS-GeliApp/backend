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
router.post("/event", authMiddleware, async (req, res) => {
    const { user_id } = req.tokenPayload;
    const { event_id } = req.body;
    try{
      const { rows } = await db.query(
        "SELECT 1 FROM user_calender_event WHERE user_id = $1 and event_id =$2",
        [user_id,event_id]
      );
      if (rows[0]) {
        res.status(409).json({
          error: `The event already added the calender`,
        });
      } else {

        await db.query(
          "Insert  into  user_calender_event(event_id, user_id) values($1::INTEGER ,$2::INTEGER)",
          [event_id,user_id],
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
router.post("/program", authMiddleware, async (req, res) => {
    const { user_id } = req.tokenPayload;
    const { program_id } = req.body;
    try{
      const { rows } = await db.query(
        "SELECT 1 FROM user_calender_program WHERE user_id = $1 and program_id =$2",
        [user_id,program_id]
      );
      if (rows[0]) {
        res.status(409).json({
          error: `The program already added the calender`,
        });
      } else {

        await db.query(
          "Insert  into  user_calender_program(program_id, user_id) values($1::INTEGER ,$2::INTEGER)",
          [program_id,user_id],
        );
        res
          .status(200)
          .json("The program added the calender succesfully.");
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

//delete program to calender
  router.delete("/program", authMiddleware, async (req, res) => {
    const { user_id } = req.tokenPayload;
    const { program_id } = req.body;    
    try {
      await db.query(
        "DELETE FROM user_calender_program WHERE program_id=($1::INTEGER) and user_id=($2::INTEGER)",
        [program_id,user_id],
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
  router.delete("/event", authMiddleware, async (req, res) => {
    const { user_id } = req.tokenPayload;
    const { event_id } = req.body;   
    console.log(event_id,user_id); 
    try {
      await db.query(
        "DELETE FROM user_calender_event WHERE event_id=($1::INTEGER) and user_id=($2::INTEGER)",
        [event_id,user_id],
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
    const { user_id } = req.tokenPayload
    const { rows } = await db.query("SELECT e.program_id,  e.name,  e.program_date FROM user_calender_program uce JOIN program e ON uce.program_id = e.program_id and uce.user_id =$1 ",
                                    [user_id]);
    res.status(200).json(rows);
  });

  // Get all event_calender
router.get("/all_event", authMiddleware, async (req, res) => {
    const { user_id } = req.tokenPayload

    const { rows } = await db.query("SELECT e.event_id,  e.name,  e.event_date FROM user_calender_event uce JOIN events e ON uce.event_id = e.event_id and uce.user_id =$1 ",
    [user_id]);
    res.status(200).json(rows);
  });
