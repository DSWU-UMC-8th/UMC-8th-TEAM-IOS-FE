//
//  MovieService.swift
//  UMC8thMovieIn
//
//  Created by 이채은 on 5/28/25.
//

import Foundation
import Alamofire

final class MovieService {
    static let shared = MovieService()
    private init() {}

    private let session: Session = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10
        return Session(configuration: config)
    }()

    private let baseURL = "http://52.78.195.123:3000"

    
    func fetchMovieDetail(movieId: Int) async throws -> MovieDTO {
        let url = "\(baseURL)/api/movies/\(movieId)"
        return try await session.request(url, method: .get)
            .validate()
            .serializingDecodable(MovieDTO.self)
            .value
    }
    
    func fetchMovieReviews(movieId: Int, page: Int = 1, size: Int = 10) async throws -> ReviewDTO {
            let url = "\(baseURL)/api/movies/\(movieId)/reviews"

            let parameters: [String: Any] = [
                "movieId": movieId,
                "page": page,
                "size": size
            ]

            return try await session.request(url,method: .get, parameters: parameters, encoding: URLEncoding.default)
                .validate()
                .serializingDecodable(ReviewDTO.self)
                .value
        }
}
