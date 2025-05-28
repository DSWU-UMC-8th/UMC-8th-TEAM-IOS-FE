//
//  MyReviewViewModel.swift
//  UMC8thMovieIn
//
//  Created by 신연주 on 5/23/25.
//

import SwiftUI

class MyReviewViewModel: ObservableObject {
    @Published var myReviews: [MyReviewModel] = []
    @Published var errorMessage: String? 

    func fetchMyReview(userId: Int) {
        Task {
            do {
                let response = try await APIClient.shared.fetchMyReview(userId: userId)
                DispatchQueue.main.async {
                    if response.isSuccess {
                        self.myReviews = response.result.myReviews
                        self.errorMessage = nil
                    } else {
                        self.errorMessage = response.message
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}


/*
@Observable
class ReviewViewModel {
    let MyReviews: [ReviewModel] = [
        .init(movieTiTle: "영화제목1", movieImage: "", movieRating: 10, movieReview: "리뷰 내용 리뷰 내용 리뷰 내용 리뷰 내용 리뷰 내용 리뷰 내용 리뷰 내용 리뷰 내용 리뷰 내용 리뷰..."),
        .init(movieTiTle: "영화제목2", movieImage: "", movieRating: 4, movieReview: "리뷰 내용 리뷰 내용 리뷰 내용 리뷰 내용 리뷰 내용 리뷰 내용 리뷰 내용 리뷰 내용 리뷰 내용 리뷰..."),
        .init(movieTiTle: "영화제목3", movieImage: "", movieRating: 3, movieReview: "리뷰 내용 리뷰 내용 리뷰 내용 리뷰 내용 리뷰 내용 리뷰 내용 리뷰 내용 리뷰 내용 리뷰 내용 리뷰..."),
        ]
}
*/
