pragma solidity ^0.4.0;

contract Random {
    function unsafeBlockRandom() public returns (uint256) {
        return uint256(block.blockhash(block.number - 1)) % 100;
    }

    uint256 private _baseIncrement;

    function unsafeIncrementRandom() public returns (uint256) {
        return uint256(sha3(_baseIncrement++)) % 100;
    }
}
