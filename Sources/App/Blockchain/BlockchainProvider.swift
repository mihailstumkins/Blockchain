//
//  BlockchainProvider.swift
//  App
//
//  Created by Mihails Tumkins on 24/10/2017.
//

import Vapor
import Console

public final class BlockchainProvider: Vapor.Provider {
    
    public static var repositoryName: String = "blockchain-provider"
    
    public func boot(_ config: Config) throws {}
    
    public func boot(_ droplet: Droplet) throws {
        let blockchain = try Blockchain(hash: droplet.hash)

        // mine genesis block
        _ = try blockchain.block()

        droplet.blockchain = blockchain
        droplet.console.info("Created blockchain node \(blockchain.name)", newLine: true)
    }
    
    public init(config: Config) throws {}
    
    public func beforeRun(_ droplet: Droplet) throws {}
}
