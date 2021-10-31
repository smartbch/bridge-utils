var wif = require('wif')

window.hex2wif = function(hexStr) {
	var privateKey = new Buffer(hexStr, 'hex')
	return wif.encode(128, privateKey, true)
} 
