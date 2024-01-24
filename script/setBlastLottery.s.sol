// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/BlastLottery.sol";

contract BlastLotteryScript is Script {
    //lottery addres on sopelia is  0x02E4F2Ea0b540D0C4bb5a9D96892f442E1983D3E
    address constant LOTTERY_ADDRESS = 0x02E4F2Ea0b540D0C4bb5a9D96892f442E1983D3E;
    address constant OPERATOR = 0x9203BAdCc86A60e83a6531607b54380Da3501cdE;

    // address constant MOCK_TOKEN = 0x64ef27de2555359F5B6C6103E71C0cDf691085C7;
    // address constant GENERATOR = 0x0D210668Ae530b3Db2890a17f512C7b4dE1cb150;

    uint256 constant LOTTERY_LENGTH = 14400; // 4h
    uint256 constant TICKET_PRICE = 0.5 ether;
    uint256 constant DISCOUNT_DIVISOR = 2000;

    uint256 constant TREASURE_FEE = 2000;

    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        
        uint256 endTime  = block.timestamp + LOTTERY_LENGTH;
        uint256[6] memory REWARD_BREAKDOWNS = [uint256(200),uint256(300),uint256(500),uint256(1500),uint256(2500),uint256(5000)];
        
        vm.startBroadcast(deployerPrivateKey);

        BlastLottery lottery = BlastLottery(0x02E4F2Ea0b540D0C4bb5a9D96892f442E1983D3E);
        lottery.setOperatorAndTreasuryAndInjectorAddresses(OPERATOR, OPERATOR, OPERATOR);

        lottery.startLottery(
        endTime,
        TICKET_PRICE,
        DISCOUNT_DIVISOR,
        REWARD_BREAKDOWNS,
        TREASURE_FEE
        );

        console.log(address(lottery));
        vm.stopBroadcast();
    }
}
