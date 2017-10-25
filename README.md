## Simple blockchain using Vapor

<img src="https://image.prntscr.com/image/N8f7Xc3sQQyD85kTD_ruwg.png">

Simple Blockchain, implemented using [Vapor 2](https://vapor.codes/), a Web Framework for Swift that works on iOS, macOS, and Ubuntu.

## Endpoints

Endpoins that need payload, are using json format.

| Method | Route                     | Description                              |
| ------ | ------------------------- | ---------------------------------------- |
| GET | `/`                  | Returns whole blockchain. |
| POST | `/transaction`                  | Creates new transaction by using sender, recipienta and amount parameters. |
| POST | `/mine`                  | Mines new block using proof of work which includes all pending transactions, and rewards miner  |
| POST | `/register`                  |  Registers new node in a chain using url param |
| GET | `/resolve`                  |  Requests block data from all registered nodes and chooses if current node blocks should be replaced via 'whoever has longest valid chain is right' algorithm  |

## Build & Run

#### Swift

Build
```
swift build --configuration release
```

Run
```
.build/release/Run serve
```

To run multiple instances, change the public port number:

```
.build/release/Run serve --config:server.port=8080
.build/release/Run serve --config:server.port=8081
.build/release/Run serve --config:server.port=8082
```

#### Docker

Build

```
$ docker build -t blockchain .
```

Run

```
$ docker run --rm -p 80:8080 blockchain
```

To run multiple instances, change the public port number:

```
$ docker run --rm -p 81:8080 blockchain
$ docker run --rm -p 82:8080 blockchain
$ docker run --rm -p 83:8080 blockchain
```

### Notice

Thisi s just a toy blockhain implementation, do not use for production purposes, also currently blockchain is not persistent, so all data will be lost after app restart.