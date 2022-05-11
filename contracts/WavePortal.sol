// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 waves;

    mapping(address => uint) stats;

    constructor() {
        console.log("Hello WavePortal!");
    }

    function wave() public {
        waves += 1;
        stats[msg.sender] = stats[msg.sender] + 1;

        console.log("%s deu tchauzinho!", msg.sender);
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("temos no totoal %d tchauzinhos", waves);

        return waves;
    }

    function getStats(address adr) public view returns (uint) {
        return stats[adr];
    }
}
