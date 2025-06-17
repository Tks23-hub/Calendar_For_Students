const express = require("express");
const router = express.Router();
module.exports = router;

const Activity_Mid = require("../middleware/Activity_Mid");
const course_Mid = require("../middleware/course_Mid");

router.get(
  "/plan",
  (req, res, next) => {
    req.query.all = "true";
    next();
  },
  [course_Mid.GetAllCourses],
  (req, res) => {
    res.render("activity_add", {
      courses: req.courses_data,
      data: {},
    });
  }
);

router.post("/plan", [Activity_Mid.AddNewActivity], (req, res) => {});
