pragma solidity ^0.8.0;

contract Debugging {
    uint256[] private vars;

    function assignment() public pure {
        uint256 myVal1 = 1;
        uint256 myVal2 = 2;
        assert(myVal1 == myVal2);
    }

    function memoryAlloc() public pure {
        string memory myString = "test";
        assert(bytes(myString).length == 10);
    }

    function storageAlloc() public {
        vars.push(2);
        vars.push(3);
        assert(vars.length == 4);
    }
}
