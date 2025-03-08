// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title SimpleERC20
 * @dev A basic implementation of the ERC-20 standard token.
 */
contract SimpleERC20 {
    // Mapping to store the balance of each address
    mapping(address => uint256) private _balances;
    
    // Mapping to store allowances (who can spend how much on behalf of whom)
    mapping(address => mapping(address => uint256)) private _allowances;
    
    // Total supply of the token
    uint256 private _totalSupply;
    
    // Token metadata
    string public name;
    string public symbol;
    uint8 public decimals;

    // Event emitted when tokens are transferred
    event Transfer(address indexed from, address indexed to, uint256 value);
    
    // Event emitted when an approval is given to spend tokens
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /**
     * @dev Constructor sets the token details and initial supply.
     * @param _name Name of the token.
     * @param _symbol Symbol of the token.
     * @param _decimals Number of decimal places.
     * @param initialSupply Initial supply of tokens (in smallest unit).
     */
    constructor(string memory _name, string memory _symbol, uint8 _decimals, uint256 initialSupply) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        _totalSupply = initialSupply * (10 ** uint256(_decimals));
        _balances[msg.sender] = _totalSupply; // Assign all tokens to the contract deployer
        emit Transfer(address(0), msg.sender, _totalSupply);
    }

    /**
     * @dev Returns the total supply of tokens.
     */
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev Returns the balance of a given account.
     * @param account The address to query the balance of.
     */
    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    /**
     * @dev Transfers tokens to a specified address.
     * @param recipient The address to receive the tokens.
     * @param amount The amount of tokens to send.
     */
    function transfer(address recipient, uint256 amount) public returns (bool) {
        require(recipient != address(0), "Transfer to the zero address");
        require(_balances[msg.sender] >= amount, "Insufficient balance");
        
        _balances[msg.sender] -= amount;
        _balances[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    /**
     * @dev Allows an address to spend tokens on behalf of another.
     * @param spender The address that will spend the funds.
     * @param amount The amount of tokens to approve.
     */
    function approve(address spender, uint256 amount) public returns (bool) {
        require(spender != address(0), "Approve to the zero address");
        
        _allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    /**
     * @dev Returns the remaining amount of tokens that `spender` can spend on behalf of `owner`.
     * @param owner The address which owns the tokens.
     * @param spender The address which will spend the tokens.
     */
    function allowance(address owner, address spender) public view returns (uint256) {
        return _allowances[owner][spender];
    }

    /**
     * @dev Transfers tokens on behalf of another address (using approved allowance).
     * @param sender The address from which the tokens are sent.
     * @param recipient The address to receive the tokens.
     * @param amount The amount of tokens to send.
     */
    function transferFrom(address sender, address recipient, uint256 amount) public returns (bool) {
        require(sender != address(0), "Transfer from the zero address");
        require(recipient != address(0), "Transfer to the zero address");
        require(_balances[sender] >= amount, "Insufficient balance");
        require(_allowances[sender][msg.sender] >= amount, "Allowance exceeded");
        
        _balances[sender] -= amount;
        _balances[recipient] += amount;
        _allowances[sender][msg.sender] -= amount;
        
        emit Transfer(sender, recipient, amount);
        return true;
    }
}