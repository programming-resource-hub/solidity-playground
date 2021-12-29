pragma solidity ^0.8.0;

interface Regulator {
    function checkValue(uint256 amount) external returns (bool);

    function loan() external returns (bool);
}

contract Bank is Regulator {
    uint256 private value;
    address private owner;

    modifier ownerFunc() {
        require(owner == msg.sender);
        _;
    }

    constructor(uint256 amount) {
        value = amount;
        owner = msg.sender;
    }

    function deposit(uint256 amount) public ownerFunc {
        value += amount;
    }

    function withdraw(uint256 amount) public ownerFunc {
        if (checkValue(amount)) {
            value -= amount;
        }
    }

    function balance() public view returns (uint256) {
        return value;
    }

    function checkValue(uint256 amount) public view returns (bool) {
        // Classic mistake in the tutorial value should be above the amount
        return value >= amount;
    }

    function loan() public view returns (bool) {
        return value > 0;
    }
}

contract MyContract is Bank(10) {
    string private name;
    uint256 private age;

    function setName(string memory newName) public {
        name = newName;
    }

    function getName() public view returns (string memory) {
        return name;
    }

    function setAge(uint256 newAge) public {
        age = newAge;
    }

    function getAge() public view returns (uint256) {
        return age;
    }
}

contract TestThrows {
    function testAssert() public pure {
        assert(1 == 2);
    }

    function testRequire() public pure {
        require(2 == 1);
    }

    function testRevert() public pure {
        revert();
    }

    // Deprecated
    // function testThrow() public pure {
    //     throw;
    // }
}
