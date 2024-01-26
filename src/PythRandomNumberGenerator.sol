// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

import "./interfaces/IRandomNumberGenerator.sol";
import "./interfaces/ILottery.sol";
import "entropy-sdk-solidity/IEntropy.sol";

library CoinFlipErrors {
    error IncorrectSender();

    error InsufficientFee();
}

contract PythRandomNumberGenerator is  IRandomNumberGenerator, Ownable {


    // Event emitted when a random number is requested. The sequence number is required to reveal
    // the result of the number.
    event RandomNumberRequest(uint64 indexed sequenceNumber, bytes32 indexed commitNumber);

    // Event emitted when the result of random number is known.
    event ResultNumber(bytes32 indexed randomNumber,  uint32 indexed resultNumber);

    using SafeERC20 for IERC20;

    address public lottery;
   
    uint32 public randomResult;

    uint256 public latestLotteryId;

    IEntropy immutable entropy;
    address immutable entropyProvider;

    bytes32 public s_userRandom;
    bytes32 public s_userCommitment;
    bytes32 public s_randomResult;
    uint64 public s_sequenceNumber;

    constructor(address _entropy, address _entropyProvider) {
        entropy = IEntropy(_entropy);
        entropyProvider = _entropyProvider;
    }

    /**
     * @notice Request randomness from a user-provided seed
     * @param random: seed provided by the  lottery
     */
    function getRandomNumber(uint256 random) external override {
        require(msg.sender == lottery, "Only lottery");
        require(random != 0, "Must have valid key hash");
        

        bytes32 userRandom = bytes32(random);
        bytes32 userCommitment = keccak256(abi.encodePacked(userRandom));

        uint256 fee = entropy.getFee(entropyProvider);
        uint64 sequenceNumber = entropy.request{value: fee}(
            entropyProvider,
            userCommitment,
            true
        );

        s_userCommitment = userCommitment;
        s_sequenceNumber = sequenceNumber;
        s_userRandom = userRandom;

        emit RandomNumberRequest(sequenceNumber, userCommitment);
    }

    

    /**
     * @notice Set the address for the lottery
     * @param _lottery: address of the PancakeSwap lottery
     */
    function setLotteryAddress(address _lottery) external onlyOwner {
        lottery = _lottery;
    }

    /**
     * @notice It allows the admin to withdraw tokens sent to the contract
     * @param _tokenAddress: the address of the token to withdraw
     * @param _tokenAmount: the number of token amount to withdraw
     * @dev Only callable by owner.
     */
    function withdrawTokens(address _tokenAddress, uint256 _tokenAmount) external onlyOwner {
        IERC20(_tokenAddress).safeTransfer(address(msg.sender), _tokenAmount);
    }

    /**
     * @notice View latestLotteryId
     */
    function viewLatestLotteryId() external view override returns (uint256) {
        return latestLotteryId;
    }

    /**
     * @notice View random result
     */
    function viewRandomResult() external view override returns (uint32) {
        return randomResult;
    }


    function revealResult(
        uint64 sequenceNumber,
        bytes32 providerRandom
    )   external onlyOwner {
        require(sequenceNumber == s_sequenceNumber, "Wrong sequence number");
        
        // Reveal the random number. This call reverts if the provided values fail to match the commitments
        // from the request phase. If the call returns, randomNumber is a uniformly distributed bytes32.
        bytes32 randomNumber = entropy.reveal(
            entropyProvider,
            sequenceNumber,
            s_userRandom,
            providerRandom
        );

        s_randomResult = randomNumber;

        // You can then convert the returned bytes32 into the range required by your application.
        randomResult = uint32(1000000 + (uint256(randomNumber) % 1000000));
        latestLotteryId = ILottery(lottery).viewCurrentLotteryId();

        
        emit ResultNumber(randomNumber, randomResult);
    }

    receive() external payable {}

}
