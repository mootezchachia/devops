const router = require("express").Router();
const courseController = require("../controller/Course.controller");

const multer = require("multer");
const path = require("path");

const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, "./uploads");
    },
    filename: (req, file, cb) => {
        const newFileName = (+new Date()).toString() + path.extname(file.originalname);
        cb(null, newFileName);
    }
})

const upload = multer({ storage });


/**
 * @Path /coursePi
 */
router.route("/")
    .post(upload.single("image"), courseController.AddCourse)
    .get(courseController.GetAllCourses);
router.get("/getParticipated", courseController.GetAllCoursesParticipated);
router.get("/getBookmarked", courseController.GetAllCoursesBookmarked);
router.put("/addBookmarked", courseController.CourseBookmark);
router.put("/addParticipated", courseController.CourseParticipate);
module.exports = router;