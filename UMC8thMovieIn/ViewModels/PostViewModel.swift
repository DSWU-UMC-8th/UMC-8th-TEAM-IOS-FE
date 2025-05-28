//
//  PostViewModel.swift
//  UMC8thMovieIn
//
//  Created by 정서영 on 5/28/25.
//

import Foundation
import SwiftUI

class PostViewModel: ObservableObject {
    @Published var post = PostModel()
    
    @Published var rating: Int = 0
    @Published var isWritingReview: Bool = false
    @Published var containsSpoiler: Bool = false
    
    // 저장된 리뷰
    @Published var submittedPost: PostModel? = nil
    
    func submitReview() {
        let newPost = PostModel(rating: rating, content: text)
        submittedPost = newPost
        
        // 제출 후 초기화 or 유지할지 선택 가능
        isWritingReview = false
        print("저장된 리뷰: 평점 \(newPost.rating), 내용: \(newPost.content)")
    }
    
    //글자 수 제한
    @Published var text: String = "" {
        didSet {
            if text.count > 100 {
                text = String(text.prefix(100))
            }
        }
    }
    
    // 추천 비율 계산 (safe guard 처리)
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
}
