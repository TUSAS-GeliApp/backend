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
const multer = require('multer');
const path = require('path');
const express = require('express');
const createUploadFunction  = require('../image');
const createdownloadFunction = require('../image');
const deleteFile = require('../image');

module.exports = router;

// Get all program
router.get("/all_program", authMiddleware, async (req, res) => {
    const { rows } = await db.query("SELECT * FROM program");
    res.status(200).json(rows);
  });

  router.get("/admin_program", adminAuthMiddleware, async (req, res) => {
    const { rows } = await db.query("SELECT * FROM program");
    res.status(200).json(rows);
  });
 router.get("/admin_program/:program_id", adminAuthMiddleware, async (req, res) => {
    const { program_id } = req.params;

    const { rows } = await db.query("SELECT * FROM program WHERE program_id =$1",
    [program_id]);
    res.status(200).json(rows);
  });

  router.post("/:id/active", adminAuthMiddleware, async (req, res) => {
    const { id } = req.params;
   
    try {
      // Check if user with the given id_number is already banned
      const { rows } = await db.query(
        "SELECT * FROM program WHERE program_id = $1",
        [id]
      );
  
     
        await db.query(
          "UPDATE program  SET is_active = ($1::BOOLEAN) where program_id = ($2::INTEGER) ",
              [true,id],
          
        );
        res.status(200).json({ user_id: id });
      
    } catch (err) {
      console.error(err);
      res
        .status(500)
        .json({ error: "An error occurred while banning the user." });
    }
  });
  
  // Unban an user
  router.patch("/:id/deactive", adminAuthMiddleware, async (req, res) => {
    const { id } = req.params;
    try {
      // Check if user with the given id_number is banned
      const { rows } = await db.query(
        "SELECT * FROM program WHERE program_id = $1",
        [id]
      );
     
          await db.query(
            "UPDATE program  SET is_active = ($1::BOOLEAN) where program_id = ($2::INTEGER) ",
              [false,id],
              
            );
        res.status(200).json({ user_id: id });
      
    } catch (err) {
      console.error(err);
      res
        .status(500)
        .json({ error: "An error occurred while unbanning the user." });
    }
  });
// Tüm program konuşmacılarını al
router.get("/all_program_speaker", authMiddleware, async (req, res) => {
  const { rows } = await db.query(`
    SELECT u.user_id AS id, CONCAT(u.name, ' ', u.surname) AS name, u.job AS info, u.photo AS link
    FROM program_speaker p
    JOIN users u ON p.user_id = u.user_id
  `);
  res.status(200).json(rows);
});

// Tüm program kullanıcılarını al
router.get("/all_program_user", authMiddleware, async (req, res) => {
  const { rows } = await db.query(`
    SELECT u.user_id AS id, CONCAT(u.name, ' ', u.surname) AS name, u.job AS info, u.photo AS pp_link, CONCAT(u.instagram, ' ', u.twitter, ' ', u.linkedin, ' ', u.facebook) AS socials
    FROM program_user p
    JOIN users u ON p.user_id = u.user_id
  `);
  res.status(200).json(rows);
});

// Tüm program kullanıcılarını al
router.get("/all_program_user_admin/:program_id", adminAuthMiddleware, async (req, res) => {
    const { program_id } = req.params;

    const { rows } = await db.query(`
    SELECT users.user_id, users.name, users.surname, users.email
    FROM users
    JOIN program_user ON users.user_id = program_user.user_id
    WHERE program_user.program_id = $1;`,
    [program_id]);
    res.status(200).json(rows);
  });
  


router.get("/admin_users_with_program/:id", adminAuthMiddleware, async (req, res) => {
    const { id } = req.params;

    const { rows } = await db.query(`
    SELECT program.name
    FROM program
    JOIN program_user ON program.program_id = program_user.program_id
    WHERE program_user.user_id = $1;
    `,[id]);
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

// add user to program
router.post("/program_user", adminAuthMiddleware, async (req, res) => {
    const { user_id } = req.body;
    const { program_id } = req.body;
   try{
    const { rows } = await db.query(
    "SELECT * FROM program_user WHERE program_id = $1 and user_id = $2 ",
    [program_id , user_id]
  );

  if (rows[0]) {
    res.status(409).json({
      error: `You already add this user to this program`,
    });
  } else{  
      await db.query(
        "Insert  into  program_user(user_id, program_id) values($1::INTEGER, $2::INTEGER)",
        [user_id, program_id],
      )
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
                .json({ error: "An error occurred while adding the program." });
      };
}
});


router.delete("/:id/user", adminAuthMiddleware, async (req, res) => {
    const { id } = req.params;
    const { user_id } = req.body;
    try{
        const { rows } = await db.query(
            "SELECT * FROM program_user WHERE program_id = $1 and user_id = $2 ",
            [id , user_id]
          );
          if (rows[0]) {
            await db.query(
                "DELETE FROM program_user WHERE program_id = $1 and user_id = $2 ",
                [id , user_id]
              );
              res
                  .status(200)
                  .json({ error: "Successfully deleted user." })
        
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


 // Update program cover picture 
 router.patch("/:eventName", adminAuthMiddleware, async (req,res) => {
  
   
    const { eventName } = req.params;

    const testingme = createUploadFunction("program",eventName)
    const upload = multer({ storage: testingme });
    try{
    // Fotoğraf yükleme fonksiyonu
        const uploadSingle = upload.single('image');
        uploadSingle(req, res, (err) => {
            if (err) {
                return res.status(500).send(err.message);
            }
            if (!req.file) {
                return res.status(400).send('No file uploaded.');
            }
            
        });
        const for_db = "images" + "/" + "program" + "/" + eventName  ;
                await db.query(
                    "UPDATE program SET image_path = ($1::VARCHAR)   WHERE name = ($2::VARCHAR) ;",
                    [for_db,eventName],
                  );res.send(`File uploaded successfully: `);
    } catch (err) {
        console.error(err);
        res
        .status(500)
        .json({ error: "An error occurred while updating the user." });
    }
    });


//delete image
router.delete("/pp/:eventName", adminAuthMiddleware, async (req, res) => {
        const { eventName } = req.params;
        

        const emptyPhoto = "/images/emptyPhotos/whiteScreen.jpg"
        try{
            
            await db.query(
                "UPDATE program SET image_path = ($1::VARCHAR)   WHERE name = ($2::VARCHAR) ;",
                [emptyPhoto,eventName],
               
              );res.send(`Photo deleted successfully`);

              deleteFile("programs", email);
        } catch (err) {
            console.error(err);
            res
            .status(500)
            .json({ error: "An error occurred while updating the user." });
        }
    });


//get image
router.get('/photo/:eventName',adminAuthMiddleware,async (req, res) => {
    const eventName = req.params.eventName;
    const filename = "program"
    const aaa = eventName + ".jpg" ;
    const imagePath = path.join(__dirname, '../images/' +filename, aaa);
    fs.exists(imagePath, function (exists) {
      if (exists) {
        res.sendFile(imagePath);
      } else {
        res.status(404).send('Resim bulunamadı');
      }
    });
  });
