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
    let data: [Transaction]
    let timestamp: Date
    let prevHash: Int
    
    init(index: Int, data: [Transaction], timestamp: Date, prevHash: Int) {
        self.index = index
        self.data = data
        self.timestamp = timestamp
        self.prevHash = prevHash
    }
}

extension Block: JSONRepresentable {
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("index", index)
        try json.set("data", data)
        try json.set("timestamp", timestamp)
        try json.set("prevHash", prevHash)
        return json
    }
}
