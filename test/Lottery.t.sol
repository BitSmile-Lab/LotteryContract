// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "./utils/BaseSetupTest.sol";
import "../src/BlastLottery.sol";
import "../src/utils/MockERC20.sol";
import "../src/utils/MockRandomNumberGenerator.sol";

contract BlastLotteryTest is BaseSetup {

    uint256 constant LOTTERY_LENGTH = 14400; // 4h
    uint256 constant TICKET_PRICE = 0.5 ether;
    uint256 constant DISCOUNT_DIVISOR = 2000;

    uint256 constant TREASURE_FEE = 2000;

    function setUp() public virtual override  {
        super.setUp();
    }

    function testSetOperatorAndTreasuryAndInjectorAddresses() public{
        lottery.setOperatorAndTreasuryAndInjectorAddresses(operator, treasury, injector);

        assertEq(lottery.operatorAddress(),operator);
        assertEq(lottery.treasuryAddress(), treasury);
        assertEq(lottery.injectorAddress(), injector);
    }

    function testStartLotteryByOperator() public {
        
        uint256 lotteryId = _startLottery();
        
        BlastLottery.Lottery memory lotteryInfo = lottery.viewLottery(lotteryId);

        
        assertEq(uint256(lotteryInfo.status), uint256(BlastLottery.Status.Open));
    }

    function testBuyticket() public{

        _startLottery();

        uint32[] memory tickets = new uint32[](1);
        tickets[0] = 1234561;

        vm.prank(alice);
        lottery.buyTickets(1, tickets);

        //lottery.buyTickets("1", _ticketsBought, { from: bob });
    }

    function testCloseLottery() public{
        uint256 lotteryId = _startLottery();

        vm.warp(block.timestamp + 5 hours);
        _closeLottery(lotteryId);

    }

    function testDrawFinalNumberAndMakeLotteryClaimable() public{
        uint256 lotteryId = _startLottery();

        //buy tickets
        uint32[] memory tickets = new uint32[](1);
        tickets[0] = 1000000;
        vm.prank(alice);
        lottery.buyTickets(1, tickets);


        randomNumberGenerator.changeLatestLotteryId();
        //close lottery
        vm.warp(block.timestamp + 5 hours);
        _closeLottery(lotteryId);

        
        //draw
        vm.prank(operator);
        lottery.drawFinalNumberAndMakeLotteryClaimable(lotteryId, false);
    }


    function _startLottery()  internal returns(uint256){
        lottery.setOperatorAndTreasuryAndInjectorAddresses(operator, treasury, injector);
        uint256 endTime  = block.timestamp + LOTTERY_LENGTH;
        uint256[6] memory REWARD_BREAKDOWNS = [uint256(200),uint256(300),uint256(500),uint256(1500),uint256(2500),uint256(5000)];
        
        vm.prank(operator);
        lottery.startLottery(
        endTime,
        TICKET_PRICE,
        DISCOUNT_DIVISOR,
        REWARD_BREAKDOWNS,
        TREASURE_FEE
        );
        return lottery.currentLotteryId();
    }
    
    function _closeLottery(uint256 _lottoryId) internal{
        vm.prank(operator);
        lottery.closeLottery(_lottoryId);

    }



}
