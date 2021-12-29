pragma solidity ^0.8.0;

contract TimeBased {
    mapping(address => uint256) public _balanceOf;
    mapping(address => uint256) public _expiryOf;

    uint256 private leaseTime = 600;

    modifier expire(address _addr) {
        if (_expiryOf[_addr] >= block.timestamp) {
            _expiryOf[_addr] = 0;
            _balanceOf[_addr] = 0;
        }
        _;
    }

    function lease() public payable expire(msg.sender) returns (bool) {
        require(msg.value == 1 ether);
        require(_balanceOf[msg.sender] == 0);
        _balanceOf[msg.sender] = 1;
        _expiryOf[msg.sender] = block.timestamp + leaseTime;
        return true;
    }

    function balanceOf() public returns (uint256) {
        return balanceOf(msg.sender);
    }

    function balanceOf(address _addr) public expire(_addr) returns (uint256) {
        return _balanceOf[_addr];
    }

    function expiryOf() public returns (uint256) {
        return expiryOf(msg.sender);
    }

    function expiryOf(address _addr) public expire(_addr) returns (uint256) {
        return _expiryOf[_addr];
    }
}
