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

// Get all podcast
router.get("/all_podcasts", authMiddleware, async (req, res) => {
    const { rows } = await db.query("SELECT * FROM podcasts");
    res.status(200).json(rows);
  });

// Add new podcast admin olcak
router.post("/add_podcast", adminAuthMiddleware, async (req, res) => {
    const { content, title , podcast_link , author_name,cover_image_path} = req.body;
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
          "Insert  into  podcasts(content, title , podcast_link , author_name,cover_image_path) values($1::VARCHAR, $2::VARCHAR, $3::VARCHAR, $4::VARCHAR, $5::VARCHAR)",
          [content, title , podcast_link , author_name,cover_image_path],
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
    const {podcast_link} =req.body;
    const {cover_image_path} =req.body;
    const {author_name} = req.body;
    const { admin_id } = req.tokenPayload;
    if (admin_id === undefined) {
      return res.status(404).json({ message: "Invalid Token" });
    }
    try {
      await db.query(
        "UPDATE podcasts SET title = ($1::VARCHAR), content= ($2::VARCHAR),podcast_link = ($3::VARCHAR),author_name = ($4::VARCHAR),cover_image_path = ($5::VARCHAR) WHERE podcast_id = ($6::INTEGER);",
        [title, content ,podcast_link , author_name,cover_image_path, id],
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

// update podcast cover image
  router.patch("/:eventName", adminAuthMiddleware, async (req,res) => {
  
   
    const { eventName } = req.params;
    const testingme = createUploadFunction("podcasts",eventName)
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
        const for_db = "images" + "/" + "podcasts" + "/" + eventName  ;

                await db.query(
                    "UPDATE podcasts SET cover_image_path = ($1::VARCHAR)   WHERE title = ($2::VARCHAR) ;",
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
router.delete("/photo/:eventName", adminAuthMiddleware, async (req, res) => {
        const { eventName } = req.params;
        const emptyPhoto = "/images/emptyPhotos/whiteScreen.jpg"
        try{
            
            await db.query(
                "UPDATE podcasts SET cover_image_path = ($1::VARCHAR)   WHERE title = ($2::VARCHAR) ;",
                [emptyPhoto,eventName],
               
              );res.send(`Photo deleted successfully`);

              deleteFile("podcasts", eventName);
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
    const filename = "podcasts";
    const aaa = eventName + ".jpg" ;
    console.log(aaa)
    const imagePath = path.join(__dirname, '../images/' +filename, aaa);
    fs.exists(imagePath, function (exists) {
      if (exists) {
        res.sendFile(imagePath);
      } else {
        res.status(404).send('Resim bulunamadı');
      }
    });
  });
