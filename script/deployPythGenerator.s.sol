// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/PythRandomNumberGenerator.sol";

contract PythRandomNumberGeneratorScript is Script {

    //blast-sepolia
    address constant ENTROPY_CONTRACT_ADDRESS = 0x98046Bd286715D3B0BC227Dd7a956b83D8978603;
    address constant PROVIDER = 0x6CC14824Ea2918f5De5C2f75A9Da968ad4BD6344;


   //blast
   //0x64ef27de2555359F5B6C6103E71C0cDf691085C7

    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        PythRandomNumberGenerator randomGenerator = new PythRandomNumberGenerator(ENTROPY_CONTRACT_ADDRESS, PROVIDER);
        console.log(address(randomGenerator));
        vm.stopBroadcast();
    }
}
