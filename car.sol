/**
 *Submitted for verification at basescan.org on 2025-01-12
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Car {
    // État de la voiture : démarrée ou arrêtée
    bool public isStarted;

    // Distance parcourue par la voiture
    uint public distanceTraveled;

    // État des phares : allumés ou éteints
    bool public headlightsOn;

    // Événements pour suivre les actions
    event CarStarted();
    event CarMoved(uint distance, uint totalDistance);
    event HeadlightsToggled(bool newState);

    // Constructeur pour initialiser l'état de la voiture
    constructor() {
        isStarted = false;
        distanceTraveled = 0;
        headlightsOn = false;
    }

    // Fonction pour démarrer la voiture
    function startCar() public {
        require(!isStarted, "La voiture est deja demarree.");
        isStarted = true;
        emit CarStarted();
    }

    // Fonction pour avancer d'une distance random
    function move() public {
        require(isStarted, "La voiture doit etre demarree avant de bouger.");
        uint randomDistance = uint(keccak256(abi.encodePacked(block.timestamp, block.prevrandao))) % 100 + 1; // Distance entre 1 et 100
        distanceTraveled += randomDistance;
        emit CarMoved(randomDistance, distanceTraveled);
    }

    // Fonction pour allumer ou éteindre les phares
    function toggleHeadlights() public {
        headlightsOn = !headlightsOn;
        emit HeadlightsToggled(headlightsOn);
    }

    // Fonction pour récupérer l'état complet de la voiture
    function getCarStatus() public view returns (string memory) {
        string memory startedStatus = isStarted ? "demarree" : "arretee";
        string memory headlightsStatus = headlightsOn ? "allumes" : "eteints";
        return string(abi.encodePacked(
            "La voiture est ", startedStatus, ", les phares sont ", headlightsStatus, ", distance parcourue: ", uintToString(distanceTraveled), " metres."
        ));
    }

    // Fonction utilitaire pour convertir un uint en string
    function uintToString(uint v) internal pure returns (string memory) {
        if (v == 0) {
            return "0";
        }
        uint maxLen = 100;
        bytes memory reversed = new bytes(maxLen);
        uint i = 0;
        while (v != 0) {
            uint remainder = v % 10;
            v = v / 10;
            reversed[i++] = bytes1(uint8(48 + remainder));
        }
        bytes memory s = new bytes(i);
        for (uint j = 0; j < i; j++) {
            s[j] = reversed[i - 1 - j];
        }
        return string(s);
    }
}
