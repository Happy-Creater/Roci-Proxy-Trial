// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract RociOct20Token is ERC20 {
    constructor() ERC20("ROCI-OCT20", "roci-oct20") {
        _mint(msg.sender, 100000000 * 10 ** 18);
    }
}