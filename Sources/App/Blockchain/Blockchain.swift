//
//  Blockchain.swift
//  App
//
//  Created by Mihails Tumkins on 24/10/2017.
//

import Foundation
import Vapor

public final class Blockchain {

    let name: String
    let pow: ProofOfWorkProtocol

    private var blocks = [Block]()
    private var pending = [Transaction]()
    private var nodes = [String]()

    private let hash: HashProtocol
    private let client: ClientFactoryProtocol

    init(hash: HashProtocol, pow: ProofOfWorkProtocol, client: ClientFactoryProtocol) throws {
        self.hash = hash
        self.pow = pow
        self.client = client

        // we are hashing current timestamp as blockchain node name for simplicity
        let name = try self.hash.make("\(Date().timeIntervalSince1970)")
        self.name = name.makeString()
    }
    
    func transaction(sender: String, recipient: String, amount: Int) throws -> Transaction {
        let hash = try self.hash.make("\(sender)\(recipient)\(amount)\(Date().timeIntervalSince1970)").makeString()
        let transaction = Transaction(sender: sender, recipient: recipient, amount: amount, hash: hash)
        pending.append(transaction)
        return transaction
    }
    
    func block(proof: Int, reward: Bool = false) throws -> Block {
        if reward { try self.reward() }
        let current = self.pending
        self.pending = []

        // once again using current timestamp for hash
        let timestamp = Date().timeIntervalSince1970
        let hash = try self.hash.make("\(timestamp)").makeString()
        let prevHash = (blocks.last?.hash ?? "0")
        let block = Block(index: blocks.count + 1,
                          transactions: current,
                          timestamp: timestamp,
                          proof: proof,
                          hash: hash,
                          prevHash: prevHash)
        
        self.blocks.append(block)
        return block
    }

    // rewarding miner
    func reward() throws {
        _ = try self.transaction(sender: "0", recipient: name, amount: 1)
    }

    func last() -> Block? {
        return self.blocks.last
    }

    // register other nodes for resolving
    func register(url: String) {
        self.nodes.append(url)
    }

    // resolving conflicts by replacing chain with most length if it is valid
    func resolve() throws -> Blockchain {
        let chains: [[Block]] = self.nodes.flatMap { url ->  [Block]? in
            guard let resp = try? self.client.get(url), let json = resp.json?["blocks"]?.array else {
                return nil
            }
            return json.map{ try? Block(json: $0) }.flatMap { $0 }
        }
        .flatMap { $0 }
        .filter { $0.count > self.blocks.count }

        try chains.forEach { blocks in
            let valid = try self.valid(blocks: blocks)
            if valid {
                self.blocks = blocks
            }
        }
        return self
    }

    func valid(blocks: [Block]) throws -> Bool {
        guard var index = blocks.indices.last else { return false }
        while index - 1 >= 0 {
            let next = blocks[index]
            let prev = blocks[index - 1]
            guard next.prevHash == prev.hash,
                try self.pow.valid(prev: prev.proof, proof: next.proof ) else { return false }
            index -= 1
        }
        return true
    }
}

extension Blockchain: JSONRepresentable {
    public func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("name", name)
        try json.set("blocks", blocks)
        return json
    }
}
