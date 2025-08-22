import Vapor

struct WebFingerController {
    func webfinger(req: Request) throws -> Response {
        guard let resource = req.query[String.self, at: "resource"] else {
            throw Abort(.badRequest, reason: "Missing resource parameter")
        }
        
        let domain = Environment.get("DOMAIN") ?? "localhost:8080"
        let baseURL = Environment.get("BASE_URL") ?? "http://localhost:8080"
        let expectedAcct = "acct:testuser@\(domain)"
        let expectedUserURL = "\(baseURL)/users/testuser"
        
        if resource == expectedAcct || resource == expectedUserURL {
            let webfinger = WebFingerResource(
                subject: expectedAcct,
                links: [
                    WebFingerLink(
                        rel: "self",
                        type: "application/activity+json",
                        href: expectedUserURL
                    )
                ]
            )
            
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(webfinger)
            
            let response = Response()
            response.headers.contentType = HTTPMediaType(type: "application", subType: "jrd+json", parameters: ["charset": "utf-8"])
            response.body = .init(data: jsonData)
            return response
        }
        
        throw Abort(.notFound, reason: "Resource not found")
    }
}