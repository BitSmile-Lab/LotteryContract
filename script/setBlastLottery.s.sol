// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/BlastLottery.sol";

contract BlastLotteryScript is Script {
  
    address constant LOTTERY_ADDRESS = 0x394dCacf202B2b85616f78174696BfAe775a1CB3;
    address constant OPERATOR = 0x9203BAdCc86A60e83a6531607b54380Da3501cdE;


    uint256 constant LOTTERY_LENGTH = 14400; // 4h
    uint256 constant TICKET_PRICE = 0.0001 ether;
    uint256 constant DISCOUNT_DIVISOR = 2000;

    uint256 constant TREASURE_FEE = 0;

    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        
        uint256 endTime  = block.timestamp + LOTTERY_LENGTH;
        uint256[6] memory REWARD_BREAKDOWNS = [uint256(200),uint256(300),uint256(500),uint256(1500),uint256(2500),uint256(5000)];
        
        vm.startBroadcast(deployerPrivateKey);

        BlastLottery lottery = BlastLottery(LOTTERY_ADDRESS);
        lottery.setOperatorAndTreasuryAndInjectorAddresses(OPERATOR, OPERATOR, OPERATOR);

        lottery.setMinAndMaxTicketPriceInCake(0.00001 ether, 10 ether);

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
