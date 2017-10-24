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
            guard let block = try self.blockchain?.block() else {
                throw Abort(.badRequest)
            }
            return try block.makeJSON()
        }
    }
}
