import Vapor

func routes(_ app: Application) throws {
    let webfingerController = WebFingerController()
    let userController = UserController()
    let postController = PostController()
    
    // Root endpoint
    app.get { req in
        return "Lawrence ActivityPub Server"
    }
    
    // WebFinger endpoint
    app.get(".well-known", "webfinger", use: webfingerController.webfinger)
    
    // User endpoints
    app.get("users", ":username", use: userController.profile)
    app.get("users", ":username", "outbox", use: userController.outbox)
    
    // Post endpoints
    app.get("users", ":username", "posts", ":postId", use: postController.post)
    app.get("users", ":username", "activities", ":activityId", use: postController.activity)
}