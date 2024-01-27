// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/BlastLottery.sol";

contract BlastLotteryScript is Script {
    //lottery addres on sopelia is  0x02E4F2Ea0b540D0C4bb5a9D96892f442E1983D3E

    //blast testnet
    address constant MOCK_TOKEN = 0x4200000000000000000000000000000000000023;
    address constant GENERATOR = 0x2cC5f7304d84DC23F5d06eb646bcC45B6A3506Df;

    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        BlastLottery lottery = new BlastLottery(MOCK_TOKEN, GENERATOR);
        console.log(address(lottery));
        vm.stopBroadcast();
    }
}
