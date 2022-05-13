// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    struct Wave {
        address waver; // Endereço do usuário que deu tchauzinho
        string message; // Mensagem que o usuário envio
        uint256 timestamp; // Data/hora de quando o usuário tchauzinhou.
    }

    uint256 totalWaves;

    Wave[] waves;

    mapping(address => uint) stats;

    event NewWave(address indexed from, uint256 timestamp, string message);

    constructor() {
        console.log("Hello WavePortal!");
    }

    function wave(string memory _message) public {
        totalWaves += 1;
        stats[msg.sender] = stats[msg.sender] + 1;

        console.log("%s tchauzinhou com a mensagem %s", msg.sender, _message);

        waves.push(Wave(msg.sender, _message, block.timestamp));

        emit NewWave(msg.sender, block.timestamp, _message);
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("temos no totoal %d tchauzinhos", totalWaves);

        return totalWaves;
    }

    function getStats(address adr) public view returns (uint) {
        return stats[adr];
    }

    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }
}
