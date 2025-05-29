//
//  RecommendDTO.swift
//  UMC8thMovieIn
//
//  Created by 김미주 on 5/29/25.
//

import Foundation

struct RecommendDTO: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: RecommendResult
}

struct RecommendResult: Codable {
    let movieId: Int
}
