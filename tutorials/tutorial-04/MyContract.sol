pragma solidity ^0.8.0;

import "./Library.sol";

contract TestLibrary {
    using IntExtended for uint256;

    function testIncrement(uint256 _base) public pure returns (uint256) {
        return IntExtended.increment(_base);
    }

    function testDecrement(uint256 _base) public pure returns (uint256) {
        return IntExtended.decrement(_base);
    }

    function testIncrementByValue(uint256 _base, uint256 _value)
        public
        pure
        returns (uint256)
    {
        return _base.incrementByValue(_value);
    }

    function testDecrementByValue(uint256 _base, uint256 _value)
        public
        pure
        returns (uint256)
    {
        return _base.decrementByValue(_value);
    }
}
