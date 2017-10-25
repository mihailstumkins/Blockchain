//
//  Blockchain.swift
//  App
//
//  Created by Mihails Tumkins on 24/10/2017.
//

import Foundation
import Vapor

public class Blockchain {

    let name: String
    private var blocks = [Block]()
    private var pending = [Transaction]()

    private let hash: HashProtocol
    let pow: ProofOfWorkProtocol

    init(hash: HashProtocol, pow: ProofOfWorkProtocol) throws {
        self.hash = hash
        self.pow = pow
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
    
    func block(proof: Int) throws -> Block {

        // reward miner with one coin
        _ = try self.transaction(sender: "0", recipient: name, amount: 1)

        let current = self.pending
        self.pending = []

        // once again using current timestamp for hash
        let hash = try self.hash.make("\(Date().timeIntervalSince1970)").makeString()
        let prevHash = (blocks.last?.hash ?? "0")
        let block = Block(index: blocks.count + 1,
                          transactions: current,
                          timestamp: Date(),
                          proof: proof,
                          hash: hash,
                          prevHash: prevHash)
        
        self.blocks.append(block)
        return block
    }

    func last() -> Block? {
        return self.blocks.last
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
