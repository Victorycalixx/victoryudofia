pragma solidity >=0.7.0 <0.9.0;

contract calix {
    string public name = "calix token";
    string public symbol = "clx";
    uint256 public totalSupply = 1000000000000000000000000; // a million token
    uint8 public decimals = 18;

    event transfer(
        address indexed _from,
        address indexed _to,
        uint _value 
    );

    event approval(
        address indexed _owner,
        address indexed _spender,
        uint _value 
    );

    // to keep track of balance after transfer 
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    constructor() {
        balanceOf[msg.sender] = totalSupply;
    }

    function transferFunds(address _from, address _to, uint256 _value) public returns (bool success) {
        // require the value is greater or equal for transfer 
        require(balanceOf[msg.sender] >= _value);
        // transfer the amount and subtract the balance 
        balanceOf[msg.sender] -= _value;
        // add the balance 
        balanceOf[_to] += _value;
        emit transfer(msg.sender, _to, _value);
        return true;

    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender] [_spender] = _value;
        emit approval(msg.sender, _spender, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_value <= balanceOf[_from]);
        require(_value <= allowance[_from] [msg.sender]);
        // add the balance 
        balanceOf[_to] += _value;
        // subtract the balance for transferFrom 
        balanceOf[_from] -= _value;
        allowance[msg.sender] [_from] -= _value;
        emit transfer(_from, _to, _value);
        return true;
    }
}