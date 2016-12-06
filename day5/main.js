var utils = require("./md5.js");

var input = "ffykfhsq";
var firstPassword = "";
var secondPassword = ['_', '_', '_', '_', '_', '_', '_', '_'];
var i = 0;
console.log("Running...");
for (var c = 0; c < 8;) {
    var s = input.concat(i.toString());
    var hash = utils.md5(s);
    if (hash.slice(0, 5) == "00000") {
        if (firstPassword.length < 8) {
            firstPassword = firstPassword.concat(hash.charAt(5));
        }
        var index = parseInt(hash.charAt(5));
        if (!isNaN(index) && index < 8 && secondPassword[index] == '_') {
            secondPassword[index] = hash.charAt(6);
            c++;
        }
    }
    i++;
}
console.log("First Password: " + firstPassword);
console.log("Second Password: " + secondPassword.toString().replace(/,/g, ''));