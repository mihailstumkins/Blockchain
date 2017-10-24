import Vapor

extension Droplet {
    func setupRoutes() throws {
        get("/") { req in
            guard let blockchain = self.blockchain else {
                throw Abort(.badRequest)
            }
            return try blockchain.makeJSON()
        }
    }
}
