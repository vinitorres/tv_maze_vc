import Foundation
import Alamofire

public protocol TvMazeServiceProtocol {
    func getTvShows(page: Int, completion: @escaping (Result<[TvShow], Error>) -> Void)
    func getEpisodes(id: Int, completion: @escaping (Result<[Episode], Error>) -> Void)
    //func searchTvShow(query: String, completion: @escaping (Result<[TvShow], Error>) -> Void)
    func getActors(tvShowId: Int, completion: @escaping (Result<[Actor], Error>) -> Void)
    //    func getActorSeries(actorId: Int) async throws -> [TvShow]
}

public struct TvMazeEndpoints {
    public static let getTvShowsEndpoint = "shows?page="
    public static let getEpisodesEndpoint = "shows/{id}/episodes"
    public static let searchTvShowEndpoint = "search/shows?q="
    public static let getActorsEndpoint = "shows/{id}/cast"
}

public class TvMazeService: TvMazeServiceProtocol {
    
    private let baseUrl = Bundle.main.object(forInfoDictionaryKey: "BaseUrlTvMaze") as! String
    private let sessionManager = Session()
    
    public init() {}
    
    public func getTvShows(page: Int = 0, completion: @escaping (Result<[TvShow], Error>) -> Void) {
        let url = "\(baseUrl)\(TvMazeEndpoints.getTvShowsEndpoint)\(page)"
        sessionManager.request(url).responseDecodable(of: [TvShow].self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func getEpisodes(id: Int, completion: @escaping (Result<[Episode], Error>) -> Void) {
        let episodesUrl = TvMazeEndpoints.getEpisodesEndpoint.replacingOccurrences(of: "{id}", with: "\(id)")
        let url = "\(baseUrl)\(episodesUrl)"
        sessionManager.request(url).responseDecodable(of: [Episode].self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
//    public func searchTvShow(query: String, completion: @escaping (Result<[TvShow], Error>) -> Void) {
//        let url = URL(string: "\(baseUrl)\(TvMazeEndpoints.searchTvShowEndpoint)\(query)")!
//        sessionManager.request(url).responseDecodable(of: [TvShow].self) { response in
//            switch response.result {
//            case .success(let value):
//                completion(.success(value))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
    
    public func getActors(tvShowId: Int, completion: @escaping (Result<[Actor], Error>) -> Void) {
        let actorsUrl = TvMazeEndpoints.getActorsEndpoint.replacingOccurrences(of: "{id}", with: "\(tvShowId)")
        let url = URL(string: "\(baseUrl)\(actorsUrl)")!
        sessionManager.request(url).responseDecodable(of: [Person].self) { response in
            switch response.result {
            case .success(let value):
                var actors = [Actor]()
                for person in value {
                    actors.append(person.person)
                }
                completion(.success(actors))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //
    //    func getActorSeries(actorId: Int) async throws -> [TvShow] {
    //        let url = URL(string: "\(baseUrl)people/\(actorId)/castcredits")!
    //        let (data, response) = try await URLSession.shared.data(from: url)
    //        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
    //            throw NSError(domain: "Invalid HTTP response", code: -1, userInfo: nil)
    //        }
    //        do {
    //            let json = try JSONSerialization.jsonObject(with: data, options: [])
    //            guard let jsonArray = json as? [[String: Any]] else {
    //                throw NSError(domain: "Invalid data format", code: -1, userInfo: nil)
    //            }
    //            var tvShows = [TvShow]()
    //            let dispatchGroup = DispatchGroup()
    //            for element in jsonArray {
    //                guard let showUrlString = element["_links"]?["show"]?["href"] else {
    //                    continue
    //                }
    //                guard let showUrl = URL(string: showUrlString) else {
    //                    continue
    //                }
    //                dispatchGroup.enter()
    //                let (showData, showResponse) = try await URLSession.shared.data(from: showUrl)
    //                guard let showHttpResponse = showResponse as? HTTPURLResponse, showHttpResponse.statusCode == 200 else {
    //                    continue
    //                }
    //                let showJson = try JSONSerialization.jsonObject(with: showData, options: [])
    //                guard let showDict = showJson as? [String: Any] else {
    //                    continue
    //                }
    //                let decoder = JSONDecoder()
    //                let show = decoder.decode(TvShow.self, from: showDict)
    //                tvShows.append(show)
    //                dispatchGroup.leave()
    //            }
    //            dispatchGroup.wait()
    //            return tvShows
    //        } catch {
    //            throw error
    //        }
    //    }
    
}

