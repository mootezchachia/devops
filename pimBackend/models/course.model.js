const mongoose = require("mongoose")


const courseSchema = mongoose.Schema({
    name: String,
    description: String,
    price: Number,
    requirement: String,
    duration: Number,
    UserParticipatedList: [{
        type: String,
        default: [],
    }],
    UserBookmarkedList: [{
        type: String,
        default: [],
    }],
    image: String,
}, {
    timestamps: true
});

const Course = mongoose.model("course", courseSchema);

module.exports = { Course };