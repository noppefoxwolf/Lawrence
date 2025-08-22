import Vapor

struct PostController {
    func post(req: Request) throws -> Response {
        guard let username = req.parameters.get("username"),
              let postId = req.parameters.get("postId") else {
            throw Abort(.badRequest, reason: "Missing parameters")
        }
        
        if username == "testuser" {
            var note: Note?
            switch postId {
            case "1":
                note = TestData.testNote1
            case "2":
                note = TestData.testNote2
            default:
                break
            }
            
            if let note = note {
                let encoder = JSONEncoder()
                let jsonData = try encoder.encode(note)
                
                let response = Response()
                response.headers.contentType = HTTPMediaType(type: "application", subType: "activity+json", parameters: ["charset": "utf-8"])
                response.body = .init(data: jsonData)
                return response
            }
        }
        
        throw Abort(.notFound, reason: "Post not found")
    }
    
    func activity(req: Request) throws -> Response {
        guard let username = req.parameters.get("username"),
              let activityId = req.parameters.get("activityId") else {
            throw Abort(.badRequest, reason: "Missing parameters")
        }
        
        if username == "testuser" {
            var activity: CreateActivity?
            switch activityId {
            case "1":
                activity = TestData.testActivity1
            case "2":
                activity = TestData.testActivity2
            default:
                break
            }
            
            if let activity = activity {
                let encoder = JSONEncoder()
                let jsonData = try encoder.encode(activity)
                
                let response = Response()
                response.headers.contentType = HTTPMediaType(type: "application", subType: "activity+json", parameters: ["charset": "utf-8"])
                response.body = .init(data: jsonData)
                return response
            }
        }
        
        throw Abort(.notFound, reason: "Activity not found")
    }
}