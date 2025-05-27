//
//  MovieDTO.swift
//  UMC8thMovieIn
//
//  Created by 이채은 on 5/28/25.
//

import Foundation

struct MovieDTO: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: MovieResult
}

struct MovieResult: Codable {
    let movieId: Int
    let totalReviews: Int
    let page: Int
    let size: Int
    let reviews: [MovieInfo]
}

struct MovieInfo: Codable {
    let movieId: Int
    let moviename: String
    let releaseDate: String
    let age: Int
    let time: Int
    let content: String
    let director: String
    let score: Int
    let actor: String
    let movieImage: String
}
