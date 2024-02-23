# About
A lottery on Blast  built with Pyth Entropy for generating secure random numbers.

The codebase is broken up into 2 contracts:
- `BlastLottery.sol` 
- `PythRandomNumberGenerator.sol` 


## BlastLottery 
BlastLottery is the main contract that stores the list of lottery and ticket. It start a round by operator every 8 hours. Not all Lottery rounds are equal. When a lottery jackpot isn't won, the next round's prize pool will increase; the longer it's been since someone has won the jackpot, the larger the Lottery prize pool will be.

In this contract **Only Operator** to take the following actions:
- `startLottery`: A function that start a new lottery round. Changing this  lottery round state to  `Open`
- `closeLottery`: A function that changes this  lottery round to `Close`

- `drawFinalNumberAndMakeLotteryClaimable`: A function that draws the final number, calculate reward  per group, and make lottery claimable

- `injectYieldFunds`: A function that claims the blast native yield and gas fees,then inject award funds 

## PythRandomNumberGenerator
This codebase is based off [How to Generate Random Numbers in EVM Contracts Using Pyth Entropy](https://docs.pyth.network/entropy/generate-random-numbers/evm) a Modern, integrate Pyth Entropy into an EVM Contract to generate on-chain random numbers. 


# Getting Started

## Requirements

- [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
  - You'll know you did it right if you can run `git --version` and you see a response like `git version x.x.x`
- [foundry](https://getfoundry.sh/)
  - You'll know you did it right if you can run `forge --version` and you see a response like `forge 0.2.0 (816e00b 2023-03-16T00:05:26.396218Z)`

## Quickstart

you can run:
```
forge install
forge build
```

# Usage

## Testing

```
forge test --fork-url "https://sepolia.blast.io"
```

### Test Coverage

```
forge coverage
```

and for coverage based testing:

```
forge coverage --report debug
```

## Compatibilities

- Solc Version: >0.8.19
- Chain(s) to deploy contract to: 
  - Blast sepolia

# Subgraph
Subgraphs are open APIs on The Graph that organize and serve blockchain data to applications. Using subgraphs, developers and data consumers alike benefit from speedy access to indexed data.
## Subgraph source code for the contract
https://github.com/0502lian/LotterySubgraph
