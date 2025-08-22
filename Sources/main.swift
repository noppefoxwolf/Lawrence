import Vapor

let app = try await Application.make(.detect())
try configure(app)
try await app.execute()

func configure(_ app: Application) throws {
    app.http.server.configuration.hostname = "0.0.0.0"
    app.http.server.configuration.port = Int(Environment.get("PORT") ?? "8080") ?? 8080
    
    app.middleware.use(CORSMiddleware())
    
    try routes(app)
}