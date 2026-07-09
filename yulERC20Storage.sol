// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract YulERC20Storage {

    uint256 private totalSupp;

    mapping(address => uint256) private balances;

    mapping(address => mapping(address => uint256)) private allowances;


    function totalSupply() external view returns(uint256) {
        uint256 totalTokenSupply;
        assembly {
             totalTokenSupply := sload(totalSupp.slot)
        }
        return totalTokenSupply;
    }

}

