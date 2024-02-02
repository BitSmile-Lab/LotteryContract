// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/PythRandomNumberGenerator.sol";

contract PythRandomNumberGeneratorScript is Script {

    //blast-sepolia
    address constant ENTROPY_CONTRACT_ADDRESS = 0x98046Bd286715D3B0BC227Dd7a956b83D8978603;
    address constant PROVIDER = 0x6CC14824Ea2918f5De5C2f75A9Da968ad4BD6344;


   //blast
    address payable public  GENERATOR = payable(0xC9c4BDD43cD9970BEA1206EA6e80825DE11C047D);
    address constant LOTTERY_ADDRESS = 0x73b43Bb6AdEdA9613A186d0FA5fA2a284381aaDD;
    address constant OPERATOR = 0x9203BAdCc86A60e83a6531607b54380Da3501cdE;
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        PythRandomNumberGenerator randomGenerator = PythRandomNumberGenerator(GENERATOR);
        
        // randomGenerator.setLotteryAddress(LOTTERY_ADDRESS);
        
        // (bool success, bytes memory data) = GENERATOR.call{value: 0.001 ether}("");
        // require(success);

        // uint256 number = block.timestamp;
        // randomGenerator.getRandomNumber(number);

        uint64 sequenceNumber = 413;
        bytes32 providerRandom = 0xbab2370bd4e36c0ae443362c4d1c44d618c4dad488013dc6732fad8b352af298;
        
        randomGenerator.revealResultBlock(sequenceNumber, providerRandom);
        //console.log(number);
        vm.stopBroadcast();
    }
}
