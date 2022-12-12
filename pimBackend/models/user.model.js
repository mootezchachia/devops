const mongoose = require("mongoose")


const userSchema = mongoose.Schema({
    email: String,
    password: String,
    username: String,
}, {
    timestamps: true
});

const User = mongoose.model("user", userSchema);

module.exports = { User };