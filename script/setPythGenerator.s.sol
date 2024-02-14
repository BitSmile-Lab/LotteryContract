// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/PythRandomNumberGenerator.sol";

contract PythRandomNumberGeneratorScript is Script {

    //blast-sepolia
    address constant ENTROPY_CONTRACT_ADDRESS = 0x98046Bd286715D3B0BC227Dd7a956b83D8978603;
    address constant PROVIDER = 0x6CC14824Ea2918f5De5C2f75A9Da968ad4BD6344;


   //blast
    address payable public  GENERATOR = payable(0x6B394A710249DDA7bd6212Bb9029DD9B3bD1554a);
    address constant LOTTERY_ADDRESS = 0xc3D7F4a93f88a1C561704D568F82a8af88b2dc0a;
    address constant OPERATOR = 0xEF45bEcB57Ded24cf0F5bcF22D33B829167Adf89;
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        PythRandomNumberGenerator randomGenerator = PythRandomNumberGenerator(GENERATOR);
        
        randomGenerator.setLotteryAddress(LOTTERY_ADDRESS);
        
        (bool success, bytes memory data) = GENERATOR.call{value: 0.001 ether}("");
        require(success);

        // uint256 number = block.timestamp;
        // randomGenerator.getRandomNumber(number);

        // uint64 sequenceNumber = 2546;
        // bytes32 providerRandom = 0xcd00f9a134c82be03b480304d630e11bc8920a15bbb232ef2507239e6e9aaf27;
        
        // randomGenerator.revealResultBlock(sequenceNumber, providerRandom);
        //console.log(number);
        vm.stopBroadcast();
    }
}
