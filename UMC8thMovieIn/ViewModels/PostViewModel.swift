//
//  PostViewModel.swift
//  UMC8thMovieIn
//
//  Created by 정서영 on 5/28/25.
//

import Foundation
import SwiftUI

struct ReviewRequest: Encodable {
    let movie_id: Int
    let rating: Int
    let content: String
    let spoiler: Bool
    let feeling_tags: [Int]
}

class PostViewModel: ObservableObject {
    @AppStorage("token") var token: String = ""
    @Published var post = PostModel()
    @Published var rating: Int = 0
    @Published var isWritingReview: Bool = false
    @Published var containsSpoiler: Bool = false
    @Published var text: String = "" {
        didSet {
            if text.count > 100 {
                text = String(text.prefix(100))
            }
        }
    }
    
    @Published var submittedPost: PostModel? = nil
    @Published var errorMessage: String?

    // 추천 비율 계산
    var likeRatio: CGFloat {
        let total = post.likeCount + post.dislikeCount
        guard total > 0 else { return 0 }
        return CGFloat(post.likeCount) / CGFloat(total)
    }

    func addLike() {
        post.likeCount += 1
    }

    func addDislike() {
        post.dislikeCount += 1
    }

    // ✅ 리뷰 등록 API
    @MainActor
    func submitReview(movieID: Int, feelingTags: [Int]) async {
        let url = URL(string: "http://52.78.195.123:3000/api/reviews")!
        let requestData = ReviewRequest(
            movie_id: movieID,
            rating: rating * 2, 
            content: text,
            spoiler: containsSpoiler,
            feeling_tags: feelingTags
        )

        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            print("🪪 불러온 accessToken: \(token)")

            request.httpBody = try JSONEncoder().encode(requestData)

            let (data, response) = try await URLSession.shared.data(for: request)

            if let responseStr = String(data: data, encoding: .utf8) {
                print("📨 서버 응답 내용: \(responseStr)")
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                errorMessage = "유효하지 않은 응답 형식입니다."
                return
            }

            print("📡 응답 상태 코드: \(httpResponse.statusCode)")

            guard (200...299).contains(httpResponse.statusCode) else {
                errorMessage = "서버 오류: \(httpResponse.statusCode)"
                return
            }

            // 성공 시 상태 반영
            self.submittedPost = PostModel(rating: self.rating, content: self.text)
            self.isWritingReview = false
            self.text = ""
            self.rating = 0
            self.containsSpoiler = false

            print("✅ 리뷰 등록 성공")
        } catch {
            errorMessage = "리뷰 등록 실패: \(error.localizedDescription)"
        }
    }

    @Published var reviews: [PostModel] = []

    @MainActor
    func fetchReviews(for movieID: Int) async {
        guard let url = URL(string: "http://52.78.195.123:3000/api/reviews/\(movieID)") else { return }

        do {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("❌ 리뷰 목록 불러오기 실패")
                return
            }

            // 받아올 모델 배열 형태에 맞게 디코딩
            let decoded = try JSONDecoder().decode([PostModel].self, from: data)
            self.reviews = decoded
            print("📥 최신 리뷰 목록 불러오기 성공")
        } catch {
            print("❌ 리뷰 목록 에러: \(error.localizedDescription)")
        }
    }


}
