pragma solidity ^0.8.0;

interface ERC20 {
    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool);

    function approve(address _spender, uint256 _value) public returns (bool);

    function allowance(address _owner, address _spender)
        public
        constant
        returns (uint256);

    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );
}

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

contract ERC223ReceivingContract {
    function tokenFallback(
        address _from,
        uint256 _value,
        bytes _data
    ) public;
}

contract Token {
    string internal _symbol;
    string internal _name;
    uint8 internal _decimals;
    uint256 internal _totalSupply = 1000;
    mapping(address => uint256) internal _balanceOf;
    mapping(address => mapping(address => uint256)) internal _allowances;

    function Token(
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

library SafeMath {
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a * b;
        assert(a == 0 || c / a == b);
        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        // assert(b > 0); // Solidity automatically throws when dividing by 0
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold
        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        assert(b <= a);
        return a - b;
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }
}

contract MyFirstToken is
    Token("MFT", "My First Token", 18, 1000),
    ERC20,
    ERC223
{
    using SafeMath for uint256;

    function MyFirstToken() public {
        _balanceOf[msg.sender] = _totalSupply;
    }

    function totalSupply() public constant returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address _addr) public constant returns (uint256) {
        return _balanceOf[_addr];
    }

    function transfer(address _to, uint256 _value) public returns (bool) {
        if (
            _value > 0 && _value <= _balanceOf[msg.sender] && !isContract(_to)
        ) {
            _balanceOf[msg.sender] = _balanceOf[msg.sender].sub(_value);
            _balanceOf[_to] = _balanceOf[_to].add(_value);
            Transfer(msg.sender, _to, _value);
            return true;
        }
        return false;
    }

    function transfer(
        address _to,
        uint256 _value,
        bytes _data
    ) public returns (bool) {
        if (_value > 0 && _value <= _balanceOf[msg.sender] && isContract(_to)) {
            _balanceOf[msg.sender] = _balanceOf[msg.sender].sub(_value);
            _balanceOf[_to] = _balanceOf[_to].add(_value);
            ERC223ReceivingContract _contract = ERC223ReceivingContract(_to);
            _contract.tokenFallback(msg.sender, _value, _data);
            Transfer(msg.sender, _to, _value, _data);
            return true;
        }
        return false;
    }

    function isContract(address _addr) private constant returns (bool) {
        uint256 codeSize;
        assembly {
            codeSize := extcodesize(_addr)
        }
        return codeSize > 0;
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool) {
        if (
            _allowances[_from][msg.sender] > 0 &&
            _value > 0 &&
            _allowances[_from][msg.sender] >= _value &&
            _balanceOf[_from] >= _value
        ) {
            _balanceOf[_from] = _balanceOf[_from].sub(_value);
            _balanceOf[_to] = _balanceOf[_to].add(_value);
            _allowances[_from][msg.sender] = _allowances[_from][msg.sender].sub(
                _value
            );
            Transfer(_from, _to, _value);
            return true;
        }
        return false;
    }

    function approve(address _spender, uint256 _value) public returns (bool) {
        _allowances[msg.sender][_spender] = _allowances[msg.sender][_spender]
            .add(_value);
        Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender)
        public
        constant
        returns (uint256)
    {
        return _allowances[_owner][_spender];
    }
}
