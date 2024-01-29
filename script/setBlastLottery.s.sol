// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/BlastLottery.sol";

contract BlastLotteryScript is Script {
  
    address constant LOTTERY_ADDRESS = 0xbb4089E94d82EF2Fc278d44cE37d346F679F0E5e;
    address constant OPERATOR = 0x9203BAdCc86A60e83a6531607b54380Da3501cdE;
    address constant RANDOM_GENERATOR = 0x4bE54bEeaC430b149F626eA0861c468cD9f6fAa6;


    uint256 constant LOTTERY_LENGTH = 360; // 5min
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
        
        // lottery.setOperatorAndTreasuryAndInjectorAddresses(OPERATOR, OPERATOR, OPERATOR);

        // lottery.setMinAndMaxTicketPriceInCake(0.00001 ether, 10 ether);

        // //start lottery
        lottery.startLottery(
        endTime,
        TICKET_PRICE,
        DISCOUNT_DIVISOR,
        REWARD_BREAKDOWNS,
        TREASURE_FEE
        );

       
        //close lottery
        //lottery.closeLottery(1);

       

        //draw
        //lottery.drawFinalNumberAndMakeLotteryClaimable(1, true);

        console.log(address(lottery));
        vm.stopBroadcast();
    }
}
