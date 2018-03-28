'use strict';

const nunjucks = require("nunjucks");

exports.default = nunjucks;

exports.renderImpl = function(obj) {
    return function(method) {
        return function(str) {
            return function(context) {
                return function () {
                    return obj[method](str, context);
                };
            };
        };
    };
};

exports.configureImpl = function(opts) {
    return function () {
        return nunjucks.configure(opts);
    };
};
