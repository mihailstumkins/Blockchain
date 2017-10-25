//
//  Block.swift
//  App
//
//  Created by Mihails Tumkins on 24/10/2017.
//

import Foundation
import Vapor

class Block {
    let index: Int
    let transactions: [Transaction]
    let timestamp: TimeInterval
    let proof: Int
    let prevHash: String
    let hash: String
    
    init(index: Int, transactions: [Transaction], timestamp: Date, proof: Int, hash: String, prevHash: String) {
        self.index = index
        self.transactions = transactions
        self.timestamp = timestamp.timeIntervalSince1970
        self.proof = proof
        self.hash = hash
        self.prevHash = prevHash
    }
}

extension Block: JSONRepresentable {
    func makeJSON() throws -> JSON {
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
