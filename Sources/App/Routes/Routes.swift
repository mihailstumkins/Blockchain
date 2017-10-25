import Vapor

extension Droplet {
    func setupRoutes() throws {
        get("/") { req in
            guard let blockchain = self.blockchain else {
                throw Abort(.badRequest)
            }
            return try blockchain.makeJSON()
        }

        post("/transaction") { req in
            guard let json = req.json,
                  let sender = json["sender"]?.string,
                  let recipient = json["recipient"]?.string,
                  let amount = json["amount"]?.int else {
                    throw Abort(.badRequest)
            }
            guard let transaction = try self.blockchain?.transaction(sender: sender,
                                                                     recipient: recipient,
                                                                     amount: amount) else {
                    throw Abort(.badRequest)
            }
            return try transaction.makeJSON()
        }

        post("/mine") { req in
            guard let prev = self.blockchain?.last()?.proof,
                  let next = try self.blockchain?.pow.next(prev: prev),
                  let block = try self.blockchain?.block(proof: next, reward: true) else {
                throw Abort(.badRequest)
            }

            return try block.makeJSON()
        }

        post("/register") { req in
            guard let json = req.json,
                  let url = json["url"]?.string else {
                    throw Abort(.badRequest)
            }
            self.blockchain?.register(url: url)
            return Response(status: .ok)
        }

        get("/resolve") { req in
            guard let blockchain = try self.blockchain?.resolve() else {
                throw Abort(.badRequest)
            }
            return try blockchain.makeJSON()
        }
    }
}
