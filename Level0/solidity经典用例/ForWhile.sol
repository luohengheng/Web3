// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

contract ForWhile{
    function Loop() public {
        for (uint i = 0; i < 10; i++) {
            if (i == 3) {
                continue;
            }else if (i == 5) {
                break;
            }
        }

        uint j = 0;
        while(j < 10) {
            j++;
        }
    }
}