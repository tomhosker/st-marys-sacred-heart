/*
Routes the admin pages.
*/

// Imports.
const express = require("express");

// Local imports.
const Finaliser = require("../lib/finaliser.js");
const ORM = require("../lib/orm.js");

// Constant objects.
const finaliser = new Finaliser();
const orm = new ORM();

// Constants.
const router = express.Router();

// GET home page.
router.get("/", function (req, res, next) {
    finaliser.protoRender(req, res, "admin", { title: "Admin Area" });
});

// Add records to the database.
router.get("/add/:id", function (req, res, next) {
    const action = "/uploads/insert2/"+req.params.id;
    let properties;

    if (req.params.id === "ServiceTime") {
        properties = {
            title: "Add a New Service Time",
            formAction: action
        };
        orm.getUpload2ServiceTime(req, res, properties);
    } else if(req.params.id === "Newsletter") {
        properties = {
            title: "Add a New Newsletter",
            formAction: action
        };
        finaliser.protoRender(req, res, "upload2Newsletter", properties);
    } else {
        res.redirect("/");
    }
});

// Remove records from the database.
router.get("/remove/:id", function (req, res, next) {
    const action = "/uploads/deletefrom/"+req.params.id;

    if (req.params.id === "ServiceTime") {
        orm.getDeleteFromServiceTime(req, res, action);
    } else if(req.params.id === "Newsletter") {
        orm.getDeleteFromNewsletter(req, res, action);
    } else {
        res.redirect("/");
    }
});

module.exports = router;
