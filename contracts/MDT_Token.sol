// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {ERC20} from "./ERC20.sol";
import {Ownable} from "../utils/Ownable.sol";

contract MartinDimitrovToken is ERC20("Martin Dimitrov Token", "MDT"), Ownable(msg.sender) {

    function mint(uint amount) public onlyOwner {
        _mint(msg.sender, amount * 10 ** decimals());
    }
}