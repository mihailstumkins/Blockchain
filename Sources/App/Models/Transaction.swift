//
//  Transaction.swift
//  App
//
//  Created by Mihails Tumkins on 24/10/2017.
//

import Foundation
import Vapor

class Transaction {
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
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("sender", sender)
        try json.set("recipient", recipient)
        try json.set("amount", amount)
        try json.set("hash", hash)
        return json
    }
}
