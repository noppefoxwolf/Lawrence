import Vapor

struct UserController {
    func profile(req: Request) throws -> Response {
        guard let username = req.parameters.get("username") else {
            throw Abort(.badRequest, reason: "Missing username parameter")
        }
        
        if username == "testuser" {
            let response = Response()
            
            // ActivityPub/JSONリクエストの場合
            if req.headers.accept.contains(where: { accept in
                accept.mediaType.type == "application" && 
                (accept.mediaType.subType == "activity+json" || accept.mediaType.subType == "ld+json")
            }) {
                let encoder = JSONEncoder()
                let jsonData = try encoder.encode(TestData.testUser)
                
                response.headers.contentType = HTTPMediaType(type: "application", subType: "activity+json", parameters: ["charset": "utf-8"])
                response.body = .init(data: jsonData)
                return response
            }
            
            // HTMLリクエストの場合（ブラウザやMastodonのクロール）
            response.headers.contentType = HTTPMediaType(type: "text", subType: "html", parameters: ["charset": "utf-8"])
            response.headers.add(name: "Link", value: "<\(TestData.baseURL)/users/testuser>; rel=\"alternate\"; type=\"application/activity+json\"")
            response.body = .init(string: """
            <!DOCTYPE html>
            <html>
            <head>
                <meta charset="utf-8">
                <title>@testuser@lawrence-production.up.railway.app</title>
                <link rel="alternate" type="application/activity+json" href="\(TestData.baseURL)/users/testuser">
            </head>
            <body>
                <h1>Test User</h1>
                <p>@testuser@lawrence-production.up.railway.app</p>
                <p>This is a test user for Lawrence ActivityPub server</p>
            </body>
            </html>
            """)
            return response
        }
        
        throw Abort(.notFound, reason: "User not found")
    }
    
    func outbox(req: Request) throws -> Response {
        guard let username = req.parameters.get("username") else {
            throw Abort(.badRequest, reason: "Missing username parameter")
        }
        
        if username == "testuser" {
            let baseURL = Environment.get("BASE_URL") ?? "http://localhost:8080"
            let outbox = OrderedCollection(
                context: ["https://www.w3.org/ns/activitystreams"],
                type: "OrderedCollection",
                id: "\(baseURL)/users/testuser/outbox",
                totalItems: 2,
                orderedItems: [TestData.testActivity2, TestData.testActivity1]
            )
            
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(outbox)
            
            let response = Response()
            response.headers.contentType = HTTPMediaType(type: "application", subType: "activity+json", parameters: ["charset": "utf-8"])
            response.body = .init(data: jsonData)
            return response
        }
        
        throw Abort(.notFound, reason: "User not found")
    }
}