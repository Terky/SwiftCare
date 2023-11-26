import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // register routes
    try routes(app)
    try app.register(collection: EventsController())

    // var content = ContentConfig.default()
    // let encoder = JSONEncoder()
    // encoder.
    // let decoder = JSONDecoder()
    // decoder.keyDecodingStrategy = .convertFromSnakeCase
    // content.use(encoder: encoder, for: .json)
    // content.use(decoder: decoder, for: .json)
    // services.register(content)
}
