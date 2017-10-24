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
    let uuid: String
    
    init(sender: String, recipient: String, amount: Int) {
        self.sender = sender
        self.recipient = recipient
        self.amount = amount
        self.uuid = UUID().uuidString
    }
}

extension Transaction: JSONRepresentable {
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("sender", sender)
        try json.set("recipient", recipient)
        try json.set("amount", amount)
        try json.set("uuid", uuid)
        return json
    }
}
