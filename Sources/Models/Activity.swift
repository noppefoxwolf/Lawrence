import Vapor
import Foundation

struct CreateActivity: Codable, Content {
    let context: [String]
    let type: String
    let id: String
    let actor: String
    let published: String
    let to: [String]
    let object: Note
    
    private enum CodingKeys: String, CodingKey {
        case context = "@context"
        case type, id, actor, published, to, object
    }
}

struct OrderedCollection: Codable, Content {
    let context: [String]
    let type: String
    let id: String
    let totalItems: Int
    let orderedItems: [CreateActivity]
    
    private enum CodingKeys: String, CodingKey {
        case context = "@context"
        case type, id, totalItems, orderedItems
    }
}