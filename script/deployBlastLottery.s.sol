// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/BlastLottery.sol";

contract BlastLotteryScript is Script {
    //lottery addres on sopelia is  0x02E4F2Ea0b540D0C4bb5a9D96892f442E1983D3E

    address constant MOCK_TOKEN = 0x64ef27de2555359F5B6C6103E71C0cDf691085C7;
    address constant GENERATOR = 0x0D210668Ae530b3Db2890a17f512C7b4dE1cb150;

    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        BlastLottery lottery = new BlastLottery(MOCK_TOKEN, GENERATOR);
        console.log(address(lottery));
        vm.stopBroadcast();
    }
}
