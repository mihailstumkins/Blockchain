//
//  Blockchain.swift
//  App
//
//  Created by Mihails Tumkins on 24/10/2017.
//

import Foundation
import Vapor

public class Blockchain {
    
    let uuid: String
    private var blocks = [Block]()
    private var pending = [Transaction]()
    
    init() {
        uuid = UUID().uuidString
    }
    
    func newTransaction(sender: String, recipient: String, amount: Int) {
        let transaction = Transaction(sender: sender, recipient: recipient, amount: amount)
        pending.append(transaction)
    }
    
    func newBlock() {
        let current = self.pending
        self.pending = []
        
        let prevHash = (blocks.last?.prevHash ?? 0)
        let block = Block(index: blocks.count + 1,
                          data: current,
                          timestamp: Date(),
                          prevHash: prevHash)
        
        self.blocks.append(block)
    }
}

extension Blockchain: JSONRepresentable {
    public func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("node", uuid)
        try json.set("blocks", blocks)
        try json.set("pending", pending)
        return json
    }
}
