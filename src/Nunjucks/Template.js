'use strict';

const nunjucks = require("nunjucks");

exports.compile = function(str) {
    return function() {
        return nunjucks.compile(str);
    };
};

exports.renderImpl = function(template) {
    return function(context) {
        return function() {
            return template.render(context);
        };
    };
};
