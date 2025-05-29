//
//  MyReviewModel.swift
//  UMC8thMovieIn
//
//  Created by 신연주 on 5/23/25.
//

import Foundation
import SwiftUI

struct MyReviewResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [MyReviewModel]
}

struct MyReviewModel: Decodable {
    let reviewId: Int
    let movieId: Int
    let movieTitle: String
    let movieImage: String
    let rating: Int
    let content: String
    let created_at: String
}

