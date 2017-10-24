//
//  Droplet+Blockchain.swift
//  App
//
//  Created by Mihails Tumkins on 24/10/2017.
//

import Vapor

extension Droplet {
    public internal(set) var blockchain: Blockchain? {
        get {
            return storage[BlockchainProvider.repositoryName] as? Blockchain
        }
        set {
            storage[BlockchainProvider.repositoryName] = newValue
        }
    }
}
