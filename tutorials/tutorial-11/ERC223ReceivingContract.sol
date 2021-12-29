pragma solidity ^0.8.0;

contract ERC223ReceivingContract {
    function tokenFallback(
        address _from,
        uint256 _value,
        bytes _data
    ) public;
}
