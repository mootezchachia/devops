const router = require("express").Router();
const userController = require("../controller/user.controller");


/**
 * @Path /users
 */

router.post('/login', userController.signInUser);
router.post('/signup', userController.signUpUser)
router.post('/update', userController.updateProfile);
module.exports = router;