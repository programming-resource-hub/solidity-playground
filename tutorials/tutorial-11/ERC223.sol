pragma solidity ^0.8.0;

interface ERC223 {
    function transfer(
        address _to,
        uint256 _value,
        bytes _data
    ) public returns (bool);

    event Transfer(
        address indexed from,
        address indexed to,
        uint256 value,
        bytes indexed data
    );
}
