// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0;


// ----------------------------------------------------------------------------
// 'RafaCoin' token contract
//
// Deployed to : add adrress later
// Symbol      : RCOIN
// Name        : RafaCoin
// Decimals    : 18
//
// Just for study! Not an actual token
//
// @author Rafael Galdino da Silva
// ----------------------------------------------------------------------------

contract RafaCoin {

    //Basic token information
    string public constant name = "RafaCoin";
    string public constant symbol = "RAFA";
    uint8 public constant decimals = 18;
    uint256 public totalSupply;

    //Standard events of ERC-20 standard
    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);

    //Mapping the balances and the allowed tokens
    mapping(address => uint256) balances;
    mapping(address => mapping (address => uint256)) allowed;

    constructor(uint256 supply) {
        totalSupply = supply;
        balances[msg.sender] = totalSupply;
    }

    function getTotalSupply() public view returns (uint256) {
      return totalSupply;
    }

    function getBalance(address owner) public view returns (uint) {
        return balances[owner];
    }

    //Will transfer [amount] from the caller adress to [destinyAdress]
    function transfer(address destinyAdress, uint amount) public returns (bool) {
        //Check if the sender has enough tokens to send, then do the math
        require(amount <= balances[msg.sender]);
        balances[msg.sender] -= amount;
        balances[destinyAdress] += amount;
        
        //Trigger the Transfer event
        emit Transfer(msg.sender, destinyAdress, amount);

        return true;

    }

    //The caller will give allowance to [spender] of the [amount] of tokens
    function approve(address spender, uint amount) public returns (bool) {
        allowed[msg.sender][spender] = amount;

        //This will trigger the Approval event
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    //Returns the amount of tokens that [spender] is allowed to spend on behalf of [owner]
    function allowance(address owner, address spender) public view returns (uint) {
        return allowed[owner][spender];
    }

    //To make a transfer of [amount] from [sender] to [recipient] using allowance mechanism
    function transferFrom(address sender, address recipient, uint amount) public returns (bool) {
        require(amount <= balances[sender]);
        require(amount <= allowed[sender][msg.sender]);

        balances[sender] -= amount;
        allowed[sender][msg.sender] -= amount;
        balances[sender] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }
    
}