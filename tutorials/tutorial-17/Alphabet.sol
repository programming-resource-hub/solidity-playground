pragma solidity ^0.8.0;

interface Letter {
    function n() external returns (uint256);
}

contract A is Letter {
    function n() public returns (uint256) {
        return 1;
    }
}

contract B is A {}

contract C is Letter {
    function n() public pure returns (uint256) {
        return 2;
    }

    function x() public pure returns (string memory) {
        return "x";
    }
}

contract Alphabet {
    Letter[] private letters;

    event Printer(uint256);

    constructor() {
        letters.push(new A());
        letters.push(new B());
        letters.push(new C());
    }

    function loadRemote(
        address _addrX,
        address _addrY,
        address _addrZ
    ) public {
        letters.push(Letter(_addrX));
        letters.push(Letter(_addrY));
        letters.push(Letter(_addrZ));
    }

    function printLetters() public {
        for (uint256 i = 0; i < letters.length; i++) {
            emit Printer(letters[i].n());
        }
    }
}
