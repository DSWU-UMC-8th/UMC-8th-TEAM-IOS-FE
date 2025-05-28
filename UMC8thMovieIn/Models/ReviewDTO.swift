//
//  ReviewDTO.swift
//  UMC8thMovieIn
//
//  Created by 이채은 on 5/28/25.
//

import Foundation

struct ReviewDTO: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [MovieReview]
}

struct MovieReview: Identifiable, Codable {
    let reviewId: Int
    let userId: Int
    let nickname: String
    let rating: Int
    let content: String
    let created_at: String

    var id: Int { reviewId }
    
    var starRating: Int {
        return Int(floor(Double(rating) / 2.0))
    }
}
