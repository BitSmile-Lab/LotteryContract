// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {console} from "forge-std/console.sol";
import {stdStorage, StdStorage, Test} from "forge-std/Test.sol";

import {Utils} from "./Utilities.sol";
import {MockERC20} from "../../src/utils/MockERC20.sol";
import {MockRandomNumberGenerator} from "../../src/utils/MockRandomNumberGenerator.sol";
import "../../src/BlastLottery.sol";

contract BaseSetup is Test {

    uint256 constant MAX_INT = ~uint256(0);
    uint256 constant TOTAL_SUPPLY = 100000 ether;
    Utils internal utils;
    address payable[] internal users;

    address internal alice;
    address internal bob;
    address internal injector;
    address internal treasury;
    address internal operator;

    //tokens
    MockERC20 public mockCake;
    
    MockRandomNumberGenerator public randomNumberGenerator;
    BlastLottery public lottery;

    function setUp() public virtual {
        utils = new Utils();
        users = utils.createUsers(5);

        alice = users[0];
        vm.label(alice, "Alice");
        bob = users[1];
        vm.label(bob, "Bob");

        injector = users[2];
        vm.label(injector, "Injector");
        treasury = users[3];
        vm.label(treasury, "Treasury");

        operator = users[4];
        vm.label(operator, "Operator");

        _deployTestTokenContracts();

        lottery = new BlastLottery(address(mockCake), address(randomNumberGenerator));

        //allocateTokensAndApprovals(alice, uint128(MAX_INT));
        //allocateTokensAndApprovals(bob, uint128(MAX_INT));
    }

    /**
     * @dev deploy test token contracts
     */
    function _deployTestTokenContracts() internal {
        mockCake = new MockERC20("Mock CAKE", "CAKE",TOTAL_SUPPLY);
        randomNumberGenerator = new MockRandomNumberGenerator();
       
    }

    /**
     * @dev allocate amount of each token, 1 of each 721, and 1, 5, and 10 of respective 1155s
     */
    function allocateTokensAndApprovals(address _to, uint128 _amount) internal {
        mockCake.mint(_to, _amount);

        _setApprovals(_to);
    }

    function _setApprovals(address _owner) internal virtual {
        vm.startPrank(_owner);

        //erc20
        mockCake.approve(address(lottery), MAX_INT);

        vm.stopPrank();
    }
}
