//
//  Transaction.swift
//  App
//
//  Created by Mihails Tumkins on 24/10/2017.
//

import Foundation
import Vapor

public final class Transaction {
    let sender: String
    let recipient: String
    let amount: Int
    let hash: String
    
    init(sender: String, recipient: String, amount: Int, hash: String) {
        self.sender = sender
        self.recipient = recipient
        self.amount = amount
        self.hash = hash
    }
}

extension Transaction: JSONRepresentable {
    public func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("sender", sender)
        try json.set("recipient", recipient)
        try json.set("amount", amount)
        try json.set("hash", hash)
        return json
    }
}

extension Transaction: JSONInitializable {
    public convenience init(json: JSON) throws {
        self.init(sender: try json.get("sender"),
                  recipient: try json.get("recipient"),
                  amount: try json.get("amount"),
                  hash: try json.get("hash"))
    }
}
