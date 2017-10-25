# Basic blockchain using Vapor

[Vapor 2](https://vapor.codes/), a Web Framework for Swift that works on iOS, macOS, and Ubuntu.


#### Endpoints

| Method | Route                     | Description                              |
| ------ | ------------------------- | ---------------------------------------- |
| GET | `/`                  | Returns whole blockchain. |
| POST | `/transaction`                  | Creates new transaction by using sender, recipienta and amount parameters. |
| POST | `/mine`                  | Mines new block using proof of work which includes all pending transactions, and rewards miner  |

### Demo

<img src="https://image.prntscr.com/image/N8f7Xc3sQQyD85kTD_ruwg.png">

### Notice

Thisi s just a toy blockhain implementation, do not use for production purposes, also currently blockchain is not persistent, so all data will be lost after app restart.