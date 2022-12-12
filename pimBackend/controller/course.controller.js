const { Course } = require("../models/course.model");

module.exports = {
    AddCourse: async (req, res) => {
        const course = new Course({
            ...req.body
        })
        console.log(req.file.path);
        console.log(req.file);
        if (req.file != null) {
            course.image = req.file.path;
        }
        try {
            const newCourse = await course.save()
            res.status(201).json(newCourse)
        } catch (err) {
            console.log(err.message)
        }
    },

    GetAllCourses: async (req, res) => {
        try {
            const course = await Course.find()
            var cour = []
            course.forEach((item) => {
                if (!item.UserParticipatedList.includes(req.headers.id)) {
                    cour.push(item)
                }
            })
            res.json(cour)
        } catch (err) {
            res.status(500).json({ message: err.message })
        }
    },

    GetAllCoursesParticipated: async (req, res) => {
        try {
            const course = await Course.find()
            var cour = []
            course.forEach((item) => {
                if (item.UserParticipatedList.includes(req.headers.id)) {
                    cour.push(item)
                }
            })
            res.json(cour)
        } catch (err) {
            res.status(500).json({ message: err.message })
        }
    },

    GetAllCoursesBookmarked: async (req, res) => {
        try {
            const course = await Course.find()
            var cour = []
            course.forEach((item) => {
                if (item.UserBookmarkedList.includes(req.headers.id)) {
                    cour.push(item)
                }
            })
            res.json(cour)
        } catch (err) {
            res.status(500).json({ message: err.message })
        }
    },

    CourseParticipate: async (req, res) => {
        try {
            const course = await Course.findOne({ _id: req.body.id });
            course.UserParticipatedList.push(req.body.userId)
            await course.save();

            res.status(201).json(course)
        } catch (err) {
            res.status(500).json({ message: err.message })
        }
    },

    CourseBookmark: async (req, res) => {
        try {
            const course = await Course.findOne({ _id: req.body.id });
            course.UserBookmarkedList.push(req.body.userId)
            await course.save();

            res.status(201).json(course)
        } catch (err) {
            res.status(500).json({ message: err.message })
        }
    },

}