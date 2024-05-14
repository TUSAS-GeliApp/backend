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


// apply program for user
router.post("/:id/apply", authMiddleware, async (req, res) => {
    const { id } = req.params;
    const { user_id } = req.tokenPayload;
   
    try{
      const { rows } = await db.query(
        "SELECT * FROM apply_program WHERE program_id = $1 and user_id = $2 ",
        [id , user_id]
      );

      if (rows[0]) {
        res.status(409).json({
          error: `You already applied to this program`,
        });
      } else {

        await db.query(
          "Insert  into  apply_program(program_id ,user_id ) values($1::INTEGER, $2::INTEGER)",
          [id, user_id  ],
          req.tokenPayload.user_id,
        );
        res
          .status(200)
          .json("You applied this program succesfully.");
      }

      }
      catch{
        (err) => {
            console.error(err);
            res
              .status(500)
              .json({ error: "An error occurred while applying the program." });
          };
      }
  });


  // Get all applies for spesific program
router.get("/:program_id/applies", authMiddleware, async (req, res) => {
    const { program_id } = req.params;
    const { rows } = await db.query("SELECT * FROM apply_program WHERE program_id = $1",[program_id]);
    res.status(200).json(rows);
  });


 // confirm apply
router.post("/confirm", adminAuthMiddleware, async (req, res) => {
    const { program_id } = req.body;
    const { user_id } = req.body;
   
    try{
        const { rows } = await db.query(
            "SELECT * FROM apply_program WHERE program_id = $1 and user_id = $2 ",
            [program_id , user_id]
          );
        if (rows[0]) {
            await db.query(
                "DELETE FROM apply_program WHERE program_id = $1 and user_id = $2 ",
                [program_id , user_id]
              );
              const { rows } = await db.query(
                "SELECT * FROM apply_program WHERE program_id = $1 and user_id = $2 ",
                [program_id , user_id]
              );
              if (rows[0]) {
                  res
                  .status(409)
                  .json({ error: "An error occurred while adding the program." })
              } else  {
                await db.query(
                    "Insert  into  program_user(user_id, program_id) values($1::INTEGER, $2::INTEGER)",
                    [user_id, program_id],
                  );
                  res
                    .status(200)
                    .json("You applied this program succesfully.");

              }
            }
        else{
            res
            .status(200)
            .json("The user didn't apply this program.");
        }
    }
    catch{
        (err) => {
            console.error(err);
            res
              .status(500)
              .json({ error: "An error occurred while adding the program." });
          };
    }
});


//reject apply
router.post("/reject", adminAuthMiddleware, async (req, res) => {
    const { program_id } = req.body;
    const { user_id } = req.body;
   
    try{
        const { rows } = await db.query(
            "SELECT * FROM apply_program WHERE program_id = $1 and user_id = $2 ",
            [program_id , user_id]
          );
        if (rows[0]) {
            await db.query(
                "DELETE FROM apply_program WHERE program_id = $1 and user_id = $2 ",
                [program_id , user_id]
              );
              res
                  .status(409)
                  .json({ error: "The applied was rejected." })
            }
        else{
            res
            .status(200)
            .json("The user didn't apply this program.");
        }
    }
    catch{
        (err) => {
            console.error(err);
            res
              .status(500)
              .json({ error: "An error occurred while adding the program." });
          };
    }
});
