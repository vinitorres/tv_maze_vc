//
//  Created by Vinicius Torres
//

import Foundation

struct Episode: Decodable {
    let id: Int
    let name: String
    let number: Int
    let season: Int
    
    var thumb: URL {
        return URL(string: image["medium"] ?? "")!
    }
    
    var poster: URL {
        return URL(string: image["original"] ?? "")!
    }
    
    //let airs: Date?
    let summary: String
    var image: [String: String]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case number
        case season
        case image
        //case airs = "airstamp"
        case summary
    }
}
