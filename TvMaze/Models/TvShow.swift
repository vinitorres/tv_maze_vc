import Foundation

struct TvShow: Decodable {
    let id: Int
    let name: String
    
    var posterUrl: URL {
        return URL(string: image["original"] ?? "")!
    }
    
    var image: [String: String]
    //let airs: Date?
    //let premiered: Date?
    //let ended: Date?
    let genres: [String]
    //let schedule: Schedule
    let summary: String
    //let episodes: [Episode]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image
        case genres
        case summary
    }
}
