//
//  MovieModel.swift
//  UMC8thMovieIn
//
//  Created by 김미주 on 5/18/25.
//

import Foundation

struct MovieModel: Identifiable, Decodable {
    let id: Int
    let title: String
    let posterUrl: String

    enum CodingKeys: String, CodingKey {
        case id = "movieId"
        case title
        case posterUrl
    }
}

struct MovieResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [MovieModel]
}
