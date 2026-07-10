// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract YulERC20Storage {
    uint256 private totalSupp;

    mapping(address => uint256) private balances;

    mapping(address => mapping(address => uint256)) private allowances;

    function totalSupply() external view returns (uint256) {
        uint256 totalTokenSupply;
        assembly {
            totalTokenSupply := sload(totalSupp.slot)
        }
        return totalTokenSupply;
    }

    function balanceOf(address account) external view returns (uint256) {
        uint256 balanceOfAccount;
        assembly {
            mstore(0x00, account)
            mstore(0x20, balances.slot)
            //keccak256(offset,length)
            let slot := keccak256(0x00, 0x40)
            balanceOfAccount := sload(slot)
        }

        return balanceOfAccount;
    }

    function mint(address to, uint256 amount) external {
        assembly{
            mstore(0x00, to)
            mstore(0x20, balances.slot)
            let slot:= keccak256(0x00,0x40)

            let currentBalance:= sload(slot)
            let newBalance:= add(currentBalance, amount)

            if lt(newBalance, currentBalance) {
                revert(0,0)
            }
            sstore(slot,newBalance)

            let totalTokenSupply:= sload(totalSupp.slot)
            let newTokenSupply:= add(totalTokenSupply, amount)

            if lt(newTokenSupply, totalTokenSupply) {
                revert(0,0)
            }

            sstore(totalSupp.slot, newTokenSupply)
        }
    }


}
