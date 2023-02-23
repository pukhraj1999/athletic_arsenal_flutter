const User = require("../user/user.model");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

// msg for client errors and error for server errors
exports.signup = async (req, res) => {
  try {
    const { firstname, lastname, email, password } = req.body;
    //checking whether all fields exist
    if (!firstname || !lastname || !email || !password)
      res.status(400).json({ msg: "Please fill all fields!!" });
    //checking user exist in db
    const isUserExist = await User.findOne({ email });
    if (isUserExist) {
      return res.status(400).json({ msg: "User Already Exist!!" });
    }
    // Validating email
    const emailRegex =
      /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    if (!email.match(emailRegex))
      return res.status(400).json({
        msg: "Please enter a valid email!!",
      });
    // Validating password
    const passwdFilter =
      /(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*()+=-\?;,./{}|\":<>\[\]\\\' ~_]).{8,}/;
    if (!password.match(passwdFilter))
      return res.status(400).json({
        msg: "Please insert 1 capital character,1 digit,1 special character",
      });
    //encrypting
    const hashedPasswd = await bcrypt.hash(password, 10);
    //storing in db
    let user = new User({
      firstname,
      lastname,
      email,
      password: hashedPasswd,
    });
    user = await user.save();
    //not showing password
    user.password = "";
    return res.json(user);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.signin = async (req, res) => {
  try {
    const { email, password } = req.body;
    // Validating email
    const emailRegex =
      /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    if (!email.match(emailRegex))
      return res.status(400).json({
        msg: "Please enter a valid email!!",
      });
    const user = await User.findOne({
      email,
    });
    // checking user exist
    if (!user)
      return res.status(400).json({ msg: "Please create a account!!" });
    //compairing password
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch)
      return res.status(400).json({
        msg: "Invalid Credentials!!",
      });
    // generating token
    const token = jwt.sign({ id: user._id }, process.env.SECRET);
    //not showing password
    user.password = "";
    return res.json({ token, ...user._doc }); //user._doc remove unnecessary data
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.tokenIsValid = async (req, res) => {
  try {
    const token = req.header("authToken");
    if (!token) return res.json(false);
    const verified = jwt.verify(token, process.env.SECRET);
    if (!verified) return res.json(false);
    // user exist or not
    const user = await User.findById(verified.id);
    if (!user) return res.json(false);
    return res.json(true);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.getUser = async (req, res) => {
  try {
    const user = await User.findById(req.user_id);
    return res.json({ ...user._doc, token: req.token });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
