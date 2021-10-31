const mainnet = require("mainnet-js")
const { utf8ToBin } = require("@bitauth/libauth");

window.Wallet = mainnet.Wallet

class OpReturnData {
  constructor(buffer) {
    this.buffer = Buffer.from(buffer);
  }

  static fromString(string) {
    const length = new TextEncoder().encode(string).length;
    return new this(
      Buffer.from([...[0x6a, 0x4c, length], ...utf8ToBin(string)])
    );
  }
}

window.OpReturnDataFromString = function(s) {
	return OpReturnData.fromString(s)
}
