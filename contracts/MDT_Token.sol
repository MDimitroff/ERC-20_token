// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {ERC20} from "./ERC20.sol";

contract MartinDimitrovToken is ERC20("Martin Dimitrov Token", "MDT") {

    function mint(uint amount) public {
        _mint(msg.sender, amount * 10 ** decimals());
    }
}