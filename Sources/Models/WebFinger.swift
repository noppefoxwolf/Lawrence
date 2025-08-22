import Vapor
import Foundation

struct WebFingerResource: Codable, Content {
    let subject: String
    let links: [WebFingerLink]
}

struct WebFingerLink: Codable, Content {
    let rel: String
    let type: String?
    let href: String
}