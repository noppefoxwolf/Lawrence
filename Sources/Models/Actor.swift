import Vapor
import Foundation

struct Actor: Codable, Content {
    let context: [String]
    let type: String
    let id: String
    let preferredUsername: String
    let name: String
    let summary: String
    let url: String
    let inbox: String
    let outbox: String
    let followers: String
    let following: String
    let publicKey: PublicKey
    
    private enum CodingKeys: String, CodingKey {
        case context = "@context"
        case type, id, preferredUsername, name, summary, url, inbox, outbox, followers, following, publicKey
    }
}

struct PublicKey: Codable, Content {
    let id: String
    let owner: String
    let publicKeyPem: String
}