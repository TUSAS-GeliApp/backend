const users = require("./users");
const login = require("./login");
const events = require("./events");
const podcasts =require("./podcasts");
const videos = require("./videos");
const newsletter = require("./newsletter");
const logout = require("./logout");

module.exports = (app) => {
  app.use("/users", users);
  app.use("/login", login);
  app.use("/events", events);
  app.use("/podcasts", podcasts);
  app.use("/videos", videos);
  app.use("/newsletter", newsletter);
  app.use("/logout", logout);
};
