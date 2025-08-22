import Foundation
import Vapor

struct TestData {
    static var baseURL: String {
        Environment.get("BASE_URL") ?? "http://localhost:8080"
    }
    
    static var testUser: Actor {
        Actor(
            context: ["https://www.w3.org/ns/activitystreams"],
            type: "Person",
            id: "\(baseURL)/users/testuser",
            preferredUsername: "testuser",
            name: "Test User",
            summary: "This is a test user for Lawrence ActivityPub server",
            url: "\(baseURL)/users/testuser",
            inbox: "\(baseURL)/users/testuser/inbox",
            outbox: "\(baseURL)/users/testuser/outbox",
            followers: "\(baseURL)/users/testuser/followers",
            following: "\(baseURL)/users/testuser/following",
            publicKey: PublicKey(
                id: "\(baseURL)/users/testuser#main-key",
                owner: "\(baseURL)/users/testuser",
                publicKeyPem: "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwfkl...\n-----END PUBLIC KEY-----"
            )
        )
    }
    
    static var testNote1: Note {
        Note(
            context: ["https://www.w3.org/ns/activitystreams"],
            type: "Note",
            id: "\(baseURL)/users/testuser/posts/1",
            attributedTo: "\(baseURL)/users/testuser",
            content: "Hello, ActivityPub world! This is my first post from Lawrence server.",
            published: "2025-01-01T12:00:00Z",
            to: ["https://www.w3.org/ns/activitystreams#Public"]
        )
    }
    
    static var testNote2: Note {
        Note(
            context: ["https://www.w3.org/ns/activitystreams"],
            type: "Note",
            id: "\(baseURL)/users/testuser/posts/2",
            attributedTo: "\(baseURL)/users/testuser",
            content: "Today I'm learning about ActivityPub protocol. It's fascinating how federated social networks work!",
            published: "2025-01-01T14:30:00Z",
            to: ["https://www.w3.org/ns/activitystreams#Public"]
        )
    }
    
    static var testActivity1: CreateActivity {
        CreateActivity(
            context: ["https://www.w3.org/ns/activitystreams"],
            type: "Create",
            id: "\(baseURL)/users/testuser/activities/1",
            actor: "\(baseURL)/users/testuser",
            published: "2025-01-01T12:00:00Z",
            to: ["https://www.w3.org/ns/activitystreams#Public"],
            object: testNote1
        )
    }
    
    static var testActivity2: CreateActivity {
        CreateActivity(
            context: ["https://www.w3.org/ns/activitystreams"],
            type: "Create",
            id: "\(baseURL)/users/testuser/activities/2",
            actor: "\(baseURL)/users/testuser",
            published: "2025-01-01T14:30:00Z",
            to: ["https://www.w3.org/ns/activitystreams#Public"],
            object: testNote2
        )
    }
}