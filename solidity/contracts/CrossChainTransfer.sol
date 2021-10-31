// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import "./IERC20.sol";

contract CrossChainTransfer {
	address constant SEP206Contract = address(bytes20(uint160(0x2711)));
	
	function send(uint receiverAndAmount, uint mainChainAddr, uint mainChainTxId) public {
		uint96 amount = uint96(receiverAndAmount);
		address receiver = address(bytes20(uint160(receiverAndAmount>>96)));
		(bool success, bytes memory data) = SEP206Contract.call(
		    abi.encodeWithSignature("transferFrom(address,address,uint256)", 
					    msg.sender, receiver, uint(amount)));
		bool ok = abi.decode(data, (bool));
		require(success && ok);
	}

	function batchSend(uint[] calldata infoList) external {
		for(uint i=0; i<infoList.length; i+=3) {
			uint receiverAndAmount = infoList[i];
			uint mainChainAddr = infoList[i+1];
			uint mainChainTxId = infoList[i+2];
			send(receiverAndAmount, mainChainAddr, mainChainTxId);
		}
	}
}
