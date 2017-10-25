//
//  ProofOfWork.swift
//  App
//
//  Created by Mihails Tumkins on 25/10/2017.
//

import Foundation
import Vapor


protocol ProofOfWorkProtocol {
    func next(prev: Int) throws -> Int
    func valid(prev: Int, proof: Int) throws -> Bool
}

class ProofOfWork: ProofOfWorkProtocol {
    private let hash: HashProtocol
    
    init(hash: HashProtocol) {
        self.hash = hash
    }
    
    func next(prev: Int) throws -> Int  {
        var next = 0
        while try self.valid(prev: prev, proof: next) == false {
            next += 1
        }
        return next
    }
    
    func valid(prev: Int, proof: Int) throws -> Bool {
        let guess = "\(prev)\(proof)"
        let value = try self.hash.make(guess).makeString()
        print(value);
        return value.prefix(3) == "000" ? true : false
    }
}
