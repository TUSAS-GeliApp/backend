const Router = require("express-promise-router");
const router = new Router();

module.exports = router;

const multer = require('multer');
const path = require('path');
const fs = require('fs');



// Resimlerin depolanacağı klasörü belirle
const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        const folderName = req.params.folderName || 'defaultFolder';
        const uploadDir = path.join(__dirname, 'images', folderName);

        // Klasör var mı kontrol et, yoksa oluştur
        if (!fs.existsSync(uploadDir)) {
            fs.mkdirSync(uploadDir, { recursive: true });
        }

        cb(null, uploadDir);
    },
    filename: function (req, file, cb) {
        cb(null, Date.now() + path.extname(file.originalname));
    }
});


const upload = multer({ storage: storage });

// Görsel yüklemek için POST route'u
router.post('/:folderName', upload.single('image'), (req, res) => {

    if (!req.file) {
        return res.status(400).send('No file uploaded.');
    }
    res.send(`File uploaded successfully: ${req.file.filename}`);
});



router.get('/:filename/:imageName', (req, res) => {
    console.log(1);
    const imageName = req.params.imageName;
    const filename = req.params.filename;
    const imagePath = path.join(__dirname, '/images/' +filename, imageName);

    console.log(imagePath);
    fs.exists(imagePath, function (exists) {
      if (exists) {
        res.sendFile(imagePath);
      } else {
        res.status(404).send('Resim bulunamadı');
      }
    });
  });
