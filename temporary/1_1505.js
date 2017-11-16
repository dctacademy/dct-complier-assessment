var fs = require('fs'); var access = fs.createWriteStream('temporary/1_1505.txt'); access.truncate; process.stdout.write = process.stderr.write = access.write.bind(access); process.on('uncaughtException', function(err) { console.error((err && err.stack) ? err.stack : err); });
arr = [10,20,30,50]
puts arr.inject(:+)
a
