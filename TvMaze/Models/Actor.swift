import Foundation

struct Actor: Decodable {
    let id: Int
    let name: String
    var image: [String: String]
    
    var thumb: URL {
        return URL(string: image["medium"] ?? "")!
    }
    
    var poster: URL {
        return URL(string: image["original"] ?? "")!
    }
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case image
    }
}
