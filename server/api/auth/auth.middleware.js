const jwt = require("jsonwebtoken");

exports.auth = (req, res, next) => {
  try {
    const token = req.header("authToken");
    if (!token)
      return res.status(401).json({ msg: "No auth token!! Access denied!!" });
    const verified = jwt.verify(token, process.env.SECRET);
    if (!verified)
      return res
        .status(401)
        .json({ msg: "Token Verification failed!! Authorized denied!!" });
    req.user_id = verified.id; //storing users id as property of req
    req.token = token;
    next();
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
