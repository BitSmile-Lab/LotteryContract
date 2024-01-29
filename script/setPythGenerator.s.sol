// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/PythRandomNumberGenerator.sol";

contract PythRandomNumberGeneratorScript is Script {

    //blast-sepolia
    address constant ENTROPY_CONTRACT_ADDRESS = 0x98046Bd286715D3B0BC227Dd7a956b83D8978603;
    address constant PROVIDER = 0x6CC14824Ea2918f5De5C2f75A9Da968ad4BD6344;


   //blast
    address payable public  GENERATOR = payable(0x4bE54bEeaC430b149F626eA0861c468cD9f6fAa6);
    address constant LOTTERY_ADDRESS = 0xbb4089E94d82EF2Fc278d44cE37d346F679F0E5e;
    address constant OPERATOR = 0x9203BAdCc86A60e83a6531607b54380Da3501cdE;
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        PythRandomNumberGenerator randomGenerator = PythRandomNumberGenerator(GENERATOR);
        
        randomGenerator.setLotteryAddress(LOTTERY_ADDRESS);
        
        // (bool success, bytes memory data) = GENERATOR.call{value: 0.001 ether}("");
        // require(success);

        // uint256 number = block.timestamp;
        // randomGenerator.getRandomNumber(number);

        uint64 sequenceNumber = 254;
        bytes32 providerRandom = 0x82b70b17a0ec175ddc23caafe24b36c9b4b1925625cbac831cb157a31f1767bb;
        
        randomGenerator.revealResult(sequenceNumber, providerRandom);
        //console.log(number);
        vm.stopBroadcast();
    }
}
