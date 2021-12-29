pragma solidity ^0.8.0;

library IntExtended {
    function increment(uint256 _self) public pure returns (uint256) {
        return _self + 1;
    }

    function decrement(uint256 _self) public pure returns (uint256) {
        return _self - 1;
    }

    function incrementByValue(uint256 _self, uint256 _value)
        public
        pure
        returns (uint256)
    {
        return _self + _value;
    }

    function decrementByValue(uint256 _self, uint256 _value)
        public
        pure
        returns (uint256)
    {
        return _self - _value;
    }
}
