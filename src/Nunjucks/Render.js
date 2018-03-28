'use strict';

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
