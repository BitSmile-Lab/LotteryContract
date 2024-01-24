// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/RandomNumberGenerator.sol";

contract RandomNumberGeneratorScript is Script {

    //address on sepolia testnet is 0x0D210668Ae530b3Db2890a17f512C7b4dE1cb150

    address constant LINK_TOKEN = 0x779877A7B0D9E8603169DdbD7836e478b4624789;
    address constant VRFCoordinator = 0x8103B0A8A00be2DDC778e6e7eaa21791Cd364625;
    function setUp() public {}

    function run() public {

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        RandomNumberGenerator generator = new RandomNumberGenerator(LINK_TOKEN, VRFCoordinator);
        console.log(address(generator));
        vm.stopBroadcast();
    }
}
