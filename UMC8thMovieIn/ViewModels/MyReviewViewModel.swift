//
//  MyReviewViewModel.swift
//  UMC8thMovieIn
//
//  Created by 신연주 on 5/23/25.
//

import SwiftUI

@MainActor
class MyReviewViewModel: ObservableObject {
    @Published var myReviews: [MyReviewModel] = []
    @Published var errorMessage: String?

    func fetchMyReview(userId: Int) async {
        do {
            let response = try await APIClient.shared.fetchMyReview(userId: userId)
            if response.isSuccess {
                self.myReviews = response.result
                self.errorMessage = nil
            } else {
                self.errorMessage = response.message
                print("[❌ API 실패] 서버 응답 메시지: \(response.message)")
            }
        } catch {
            self.errorMessage = error.localizedDescription
            print("[❌ 네트워크 에러] \(error.localizedDescription)")
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
