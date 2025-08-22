import Vapor
import Foundation

struct Note: Codable, Content {
    let context: [String]
    let type: String
    let id: String
    let attributedTo: String
    let content: String
    let published: String
    let to: [String]
    
    private enum CodingKeys: String, CodingKey {
        case context = "@context"
        case type, id, attributedTo, content, published, to
    }
}