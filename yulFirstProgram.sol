// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.34;

contract Yul {
    uint256 number;

    function setNumber(uint256 num) external {
        assembly {
            sstore(number.slot, num)
        }
    }

    function getNumber() external view returns(uint256) {
        uint256 num;
        assembly {
            num := sload(number.slot)
        }
        return num;
    }

    function increment() external {
        assembly {
                let num := sload(number.slot)
                if eq(num, not(0)) {
                    //revert(offSet, byteZero)
                    revert(0,0) //empty revert
                }
                let result := add(num,1)
                sstore(number.slot, result)
        }
    }

    function decrement() external {
        assembly {
            let num := sload(number.slot)
            if eq(num,0) {
                revert(0,0)
            }
            let result := sub(num,1)
            sstore(number.slot, result)
        }
    }
}