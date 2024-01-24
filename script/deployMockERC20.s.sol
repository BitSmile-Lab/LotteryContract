// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/utils/MockERC20.sol";

contract MockERC20Script is Script {
    //token address on sepolia testnet is 0x64ef27de2555359F5B6C6103E71C0cDf691085C7

    function setUp() public {}

    function run() public {

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        MockERC20 mockToken = new MockERC20("Mock ETH", "M_ETH",100000000 ether);
        console.log(address(mockToken));
        mockToken.mint(0x9203BAdCc86A60e83a6531607b54380Da3501cdE, 10000 ether);
        vm.stopBroadcast();
        
    }
}
