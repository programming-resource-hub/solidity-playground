pragma solidity ^0.8.0;

contract ExternalContract {
    function externalCall(string calldata x) external pure returns (uint256) {
        return 123;
    }

    function publicCall(string memory x) public pure returns (uint256) {
        return 123;
    }
}
