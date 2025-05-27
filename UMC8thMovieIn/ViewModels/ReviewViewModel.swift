//
//  ReviewViewModel.swift
//  UMC8thMovieIn
//
//  Created by 신연주 on 5/23/25.
//

import SwiftUI

@Observable
class ReviewViewModel {
    let MyReviews: [ReviewModel] = [
        .init(movieTiTle: "영화제목1", movieImage: "", movieRating: 10, movieReview: "리뷰 내용 리뷰 내용 리뷰 내용 리뷰 내용 리뷰 내용 리뷰 내용 리뷰 내용 리뷰 내용 리뷰 내용 리뷰..."),
        .init(movieTiTle: "영화제목2", movieImage: "", movieRating: 4, movieReview: "리뷰 내용 리뷰 내용 리뷰 내용 리뷰 내용 리뷰 내용 리뷰 내용 리뷰 내용 리뷰 내용 리뷰 내용 리뷰..."),
        .init(movieTiTle: "영화제목3", movieImage: "", movieRating: 3, movieReview: "리뷰 내용 리뷰 내용 리뷰 내용 리뷰 내용 리뷰 내용 리뷰 내용 리뷰 내용 리뷰 내용 리뷰 내용 리뷰..."),
        ]
}
