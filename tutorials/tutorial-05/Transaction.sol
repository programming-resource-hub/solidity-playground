pragma solidity ^0.8.0;

contract Transaction {
    event SenderLogger(address);
    event ValueLogger(uint256);

    address private owner;

    modifier isOwner() {
        require(owner == msg.sender);
        _;
    }

    modifier validValue() {
        assert(msg.value >= 1 ether);
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function runCheck() public payable isOwner validValue {
        emit SenderLogger(msg.sender);
        emit ValueLogger(msg.value);
    }
}
