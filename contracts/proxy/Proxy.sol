// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Proxy {
    
    /// @dev Token Symbol -> Token Address
    mapping(string => address) private registeredTokens;

    /**
     * @notice Throws if symbol is not registed in registeredTokens mapping.
     * @param _symbol string Symbol name to assign token
     */
    modifier onlyRegisteredToken(string memory _symbol) {
        require(registeredTokens[_symbol] != address(0x0));
        _;
    }

    /**
     * @notice Register the token address to registeredTokens
     * @param _symbol string Symbol name to assign token
     * @param _token address of token contract
     */
    function registerToken(string memory _symbol, address _token) public returns (bool){
        require( _token != address(0x0));
        registeredTokens[_symbol] = _token;
        return true;
    }

    /**
     * @notice Return the totalsupply of the token
     * @param _symbol string Symbol name to assign token.
     * @dev See {IERC20-totalSupply}
     */
    function totalSupply(string memory _symbol) public view onlyRegisteredToken(_symbol) returns (uint256) {
        return IERC20(registeredTokens[_symbol]).totalSupply();
    }

    /**
     * @notice Return the balance of account's token
     * @param _symbol string Symbol name to assign token
     * @param _account address of Account
     * @dev See {IERC20-balanceOf}.
     */
    function balanceOf(string memory _symbol, address _account) public view onlyRegisteredToken(_symbol) returns (uint256) {
        return IERC20(registeredTokens[_symbol]).balanceOf(_account);
    }


     /**
     * @dev See {IERC20-transfer}.
     *
     * Requirements:
     *
     * - `recipient` cannot be the zero address.
     * - the caller must have a balance of at least `amount`.
     */
    function transfer(string memory _symbol, address _recipient, uint256 _amount) public onlyRegisteredToken(_symbol) returns (bool) {
        // (bool success, bytes memory data) = address(registeredTokens[_symbol]).delegatecall(
        //     abi.encodeWithSignature("transfer(address,uint256)", _recipient, _amount)
        // );
        // require(success, "2");

        // return abi.decode(data, (bool));
        // (bool success, bytes memory data) = address(registeredTokens[_symbol]).delegatecall(
        //     abi.encodeWithSignature("approve(address,uint256)", address(this), _amount)
        // );
        // require(success, "2");
        // require(IERC20(registeredTokens[_symbol]).approve(address(this), _amount));
        require(IERC20(registeredTokens[_symbol]).allowance(msg.sender, address(this)) >= _amount, "Approved amount is higher than the amount which would be transferred");
        require(IERC20(registeredTokens[_symbol]).transferFrom(msg.sender, _recipient, _amount));
        return true;
    }

    function test(string memory symbol) public view returns(address) {
        return registeredTokens[symbol];
    }

    /**
     * @notice Return the allowance amount for spender from owner
     * @param _symbol string Symbol name to assign token
     * @param _owner Owner address which is allowing
     * @param _spender Spender address which is allowed by owner
     * @dev See {IERC20-allowance}.
     */
    function allowance(string memory _symbol, address _owner, address _spender) public view onlyRegisteredToken(_symbol) returns (uint256) {
        return IERC20(registeredTokens[_symbol]).allowance(_owner, _spender);
    }

    /**
     * @dev See {IERC20-approve}.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    // function approve(string memory _symbol, address _spender, uint256 _amount) public onlyRegisteredToken(_symbol) returns (bool) {
    //     (bool success, bytes memory data) = registeredTokens[_symbol].delegatecall(
    //         abi.encodeWithSignature("approve(address, uint256)", _spender, _amount)
    //     );
    //     require(success);

    //     return abi.decode(data, (bool));
    // }

    /**
     * @dev See {IERC20-transferFrom}.
     *
     * Emits an {Approval} event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of {ERC20}.
     *
     * Requirements:
     *
     * - `sender` and `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     * - the caller must have allowance for ``sender``'s tokens of at least
     * `amount`.
     */
    // function transferFrom(
    //     string memory _symbol,
    //     address _sender,
    //     address _recipient,
    //     uint256 _amount
    // ) public onlyRegisteredToken(_symbol) returns (bool) {
    //     (bool success, bytes memory data) = registeredTokens[_symbol].delegatecall(
    //         abi.encodeWithSignature("transferFrom(address, address, uint256)", _sender, _recipient, _amount)
    //     );
    //     require(success);

    //     return abi.decode(data, (bool));
    // }

    /**
     * @dev Atomically increases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    // function increaseAllowance(string memory _symbol, address _spender, uint256 _addedValue) public onlyRegisteredToken(_symbol) returns (bool) {
    //     (bool success, bytes memory data) = registeredTokens[_symbol].delegatecall(
    //         abi.encodeWithSignature("increaseAllowance(address, uint256)", _spender, _addedValue)
    //     );
    //     require(success);

    //     return abi.decode(data, (bool));
    // }

    /**
     * @dev Atomically decreases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `spender` must have allowance for the caller of at least
     * `subtractedValue`.
     */
    // function decreaseAllowance(string memory _symbol, address _spender, uint256 _subtractedValue) public onlyRegisteredToken(_symbol) returns (bool) {
    //     (bool success, bytes memory data) = registeredTokens[_symbol].delegatecall(
    //         abi.encodeWithSignature("decreaseAllowance(address, uint256)", _spender, _subtractedValue)
    //     );
    //     require(success);

    //     return abi.decode(data, (bool));
    // }
}