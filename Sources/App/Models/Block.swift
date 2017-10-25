//
//  Block.swift
//  App
//
//  Created by Mihails Tumkins on 24/10/2017.
//

import Foundation
import Vapor

public final class Block {
    let index: Int
    let transactions: [Transaction]
    let timestamp: TimeInterval
    let proof: Int
    let prevHash: String
    let hash: String
    
    init(index: Int, transactions: [Transaction], timestamp: TimeInterval, proof: Int, hash: String, prevHash: String) {
        self.index = index
        self.transactions = transactions
        self.timestamp = timestamp
        self.proof = proof
        self.hash = hash
        self.prevHash = prevHash
    }
}

extension Block: JSONRepresentable {
    public func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("index", index)
        try json.set("transactions", transactions)
        try json.set("timestamp", timestamp)
        try json.set("proof", proof)
        try json.set("hash", hash)
        try json.set("prevHash", prevHash)
        return json
    }
}

extension Block: JSONInitializable {
    public convenience init(json: JSON) throws {
      self.init(index: try json.get("index"),
                transactions: try json.get("transactions"),
                timestamp: try json.get("timestamp"),
                proof: try json.get("proof"),
                hash: try json.get("hash"),
                prevHash: try json.get("prevHash"))
    }
}
