//get  const imageName = req.params.imageName;
  //const filename = req.params.filename;


  const express = require('express');
  const multer = require('multer');
  const path = require('path');
  const fs = require('fs');
  //get 
  const createdownloadFunction = (filename,imageName) => {
      const imagePath = path.join(__dirname, '/images/' +filename, imageName);
    return imagePath;
 
  };
  
  
  module.exports = createdownloadFunction;

  //post
  
  const createUploadFunction = (folderName, email) => {
    let fileExtension; // Dosya uzantısını saklamak için dışarıya tanımlanan değişken

    const storage = multer.diskStorage({
        destination: function (req, file, cb) {
            const uploadDir = path.join(__dirname, 'images', folderName);

            console.log(folderName+"hjcbkdjaflskdşa")
            // Klasör var mı kontrol et, yoksa oluştur
            if (!fs.existsSync(uploadDir)) {
                fs.mkdirSync(uploadDir, { recursive: true });
            }
            fileExtension = path.extname(file.originalname); // Dosya uzantısını belirle
            cb(null, uploadDir);
           
        },
        filename: function (req, file, cb) {
            cb(null, email + ".jpg"); // Dışarıdaki dosya uzantısını kullan
            
        },
        
    });
    
    return storage
};
module.exports = createUploadFunction 
//function deleteFile(folderName, email) {
//    const uploadDir = path.join(__dirname, 'images', folderName);
//    const filePath = path.join(uploadDir, email);
    
//    console.log(1);
//    if (fs.existsSync(filePath)) {
//        fs.unlink(filePath, (err) => {
//            if (err) {
//                throw err;
//            }
//            console.log(`File deleted: ${filePath}`);
//        });
//    } else {
//        console.log(`File not found: ${filePath}`);
//    }
//}

//
////module.exports = deleteFile;
