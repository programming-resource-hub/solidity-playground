pragma solidity ^0.8.0;

contract EtherTransferTo {
    function() external payable {}

    function getBalance() public returns (uint256) {
        return address(this).balance;
    }
}

contract EtherTransferFrom {
    EtherTransferTo private _instance;

    constructor() public {
        // _instance = EtherTransferTo(address(this));
        _instance = new EtherTransferTo();
    }

    function getBalance() public returns (uint256) {
        return address(this).balance;
    }

    function getBalanceOfInstance() public returns (uint256) {
        //return address(_instance).balance;
        return _instance.getBalance();
    }

    function() external payable {
        //msg.sender.send(msg.value);
        address(_instance).send(msg.value);
    }
}
