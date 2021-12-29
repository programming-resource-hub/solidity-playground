pragma solidity ^0.8.0;

contract Token {
    string internal _symbol;
    string internal _name;
    uint8 internal _decimals;
    uint256 internal _totalSupply = 1000;
    mapping(address => uint256) internal _balanceOf;
    mapping(address => mapping(address => uint256)) internal _allowances;

    constructor(
        string symbol,
        string name,
        uint8 decimals,
        uint256 totalSupply
    ) public {
        _symbol = symbol;
        _name = name;
        _decimals = decimals;
        _totalSupply = totalSupply;
    }

    function name() public constant returns (string) {
        return _name;
    }

    function symbol() public constant returns (string) {
        return _symbol;
    }

    function decimals() public constant returns (uint8) {
        return _decimals;
    }

    function totalSupply() public constant returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address _addr) public constant returns (uint256);

    function transfer(address _to, uint256 _value) public returns (bool);

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
}
