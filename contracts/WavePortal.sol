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

    uint256 private seed;

    mapping(address => uint256) lastWavedAt;

    event NewWave(address indexed from, uint256 timestamp, string message);

    constructor() payable {
        console.log("Hello WavePortal!");

        seed = (block.timestamp + block.difficulty) % 100;
    }

    function wave(string memory _message) public {
        require(
            lastWavedAt[msg.sender] + 35 seconds < block.timestamp,
            "Wait 35 seconds"
        );

        totalWaves += 1;

        lastWavedAt[msg.sender] = block.timestamp;

        console.log("%s tchauzinhou com a mensagem %s", msg.sender, _message);

        waves.push(Wave(msg.sender, _message, block.timestamp));

        seed = (block.difficulty + block.timestamp + seed) % 100;

        console.log("# randomico gerado: %d", seed);

        if (seed <= 50) {
            uint256 gift = 0.0001 ether;

            require(
                gift <= address(this).balance,
                "The Contract no has founds"
            );

            (bool success, ) = (msg.sender).call{value: gift}("");

            require(success, "unable to send gift");
        }

        emit NewWave(msg.sender, block.timestamp, _message);
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("temos no totoal %d tchauzinhos", totalWaves);

        return totalWaves;
    }

    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }
}
