// Storage for multimedia items content
const multer = require("multer");
const path = require("path");
const { v4: uuidv4 } = require("uuid");
const fs = require("fs");

const storageUserPP = multer.diskStorage({
  destination: (req, res, cb) => {
    const destinationPath = "./upload/image";
    if (!fs.existsSync(destinationPath)) {
      fs.mkdirSync(destinationPath, { recursive: true });
    }

    cb(null, destinationPath);
  },

  filename: (req, file, cb) => {
    console.log(file);
    cb(null, Date.now() + path.extname(file.originalname));
  },
});

const uploadPP = multer({
  storage: storageUserPP,

  fileFilter: function (req, file, cb) {
    const allowedTypes = ["image/jpg", "image/jpeg", "image/png"];
    const fileMimeType = file.mimetype;
    if (!allowedTypes.includes(fileMimeType)) {
      req.fileValidationError =
        "File types other than .jpg, .jpeg and .png cannot be attached.";
      return cb(
        null,
        false,
        new Error(
          "File types other than .jpg, .jpeg and .png cannot be attached."
        )
      );
    }
    cb(null, true);
  },
});

module.exports = {
  uploadPP,
};
