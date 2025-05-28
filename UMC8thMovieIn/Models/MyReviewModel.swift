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
    let code: String
    let message: String
    let result: MyReviewResult
}

struct MyReviewResult: Decodable {
    let myReviews: [MyReviewModel]  
}

struct MyReviewModel: Decodable {
    let movieTiTle: String
    let movieImage: String
    let movieRating: Int
    let movieReview: String 
}

