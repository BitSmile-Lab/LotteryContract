// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/BlastLottery.sol";
import "../src/utils/MockERC20.sol";

contract BlastLotteryScript is Script {
  
    address constant LOTTERY_ADDRESS = 0x73b43Bb6AdEdA9613A186d0FA5fA2a284381aaDD;
    address constant WETH_ADDRESS = 0x4200000000000000000000000000000000000023;
    uint256 constant TICKET_PRICE = 0.001 ether;
    
    uint32 constant TICKET_NUMBER = 10;

    function setUp() public {}

    function run() public {


        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        BlastLottery lottery = BlastLottery(LOTTERY_ADDRESS);
        MockERC20 weth = MockERC20(WETH_ADDRESS);

        vm.startBroadcast(deployerPrivateKey);

        weth.approve(LOTTERY_ADDRESS, TICKET_PRICE*TICKET_NUMBER);
        //buy tickets
        uint32[] memory tickets = new uint32[](TICKET_NUMBER);
        for(uint32 i=0;i<TICKET_NUMBER;i++){
            tickets[i] = 1000000 + i;
        }
        
        lottery.buyTickets(1, tickets);

        vm.stopBroadcast();
    }
}
