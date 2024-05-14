const users = require("./users");
const login = require("./login");
const events = require("./events");
const podcasts =require("./podcasts");
const videos = require("./videos");
const newsletter = require("./newsletter");
const logout = require("./logout");
const events_apply = require("./eventsApply");
const program = require("./program");
const programApply = require("./programApply");
const ban = require("./ban");
const admin = require("./admin");

module.exports = (app) => {
  app.use("/users", users);
  app.use("/login", login);
  app.use("/events", events);
  app.use("/podcasts", podcasts);
  app.use("/videos", videos);
  app.use("/newsletter", newsletter);
  app.use("/logout", logout);
  app.use("/events-apply", events_apply);
  app.use("/program-apply", programApply);
  app.use("/program", program);
  app.use("/ban", ban);
  app.use("/admin", admin);
};
