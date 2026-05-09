# TwinPayAI Core Infrastructure

This repository contains the smart contract and on-chain logic for **TwinPayAI**, deployed on the **Celo Network**. This project is specifically architected to maximize **Daily Active Users (DAU)** by gamifying on-chain interactions.

# Smart Contract : 0xd7E14B16CEFcAcc05349815022DFD4e2Fd7ae232

## Key Features

### 1. TwinPay SBT (Identity)
- **Soulbound Token**: A non-transferable NFT that serves as a permanent user identity.
- **On-chain Credibility**: Users must mint their SBT to start building their TwinPay reputation (XP).

### 2. Daily AI Governance (Polls)
- **Interactive DAU**: Every 24 hours, an AI-themed poll is generated (e.g., *Gemini vs OpenAI*).
- **Frictionless Voting**: Users cast votes directly on-chain, creating unique transaction signatures and consistent daily activity.

### 3. On-chain Feedback Loop
- **Decentralized Suggestions**: Users can submit UI/UX suggestions directly to the contract.
- **Incentivized Participation**: Submitting suggestions rewards users with XP, stored within the contract state.

## Technical Stack
- **Network**: Celo (EVM Compatible)
- **Language**: Solidity 0.8.20
- **Integration**: Designed for **Reown AppKit** (WalletConnect)
- **Security**: Zero-dependency architecture (Lightweight & Gas Efficient)

## Contract Details
- **Contract Name**: `TwinPayAI_Core`
- **License**: MIT
- **Features**: Custom XP tracking, non-transferable logic, and daily cooldown timers for spam prevention.

## DAU Strategy
TwinPayAI drives daily retention by:
1. Limiting suggestions to **one per 24 hours**.
2. Refreshing polls daily to encourage **consecutive check-ins**.
3. Displaying user **XP levels** on the frontend to trigger "completionist" psychology.

---
*Developed by ward.eth*
