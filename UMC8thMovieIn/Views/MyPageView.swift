//
//  MyPageView.swift
//  UMC8thMovieIn
//
//  Created by 신연주 on 5/18/25.
//

import SwiftUI

struct MyPageView: View {
    @State private var viewModel = ReviewViewModel()
    @AppStorage("nickName") private var nickName: String = "닉네임"
    @AppStorage("email") private var email: String = "email@naver.com"
    
    var body: some View {
        VStack (spacing: 0){
            infoGroup
            
            myReviewGroup
        }
    }
    
    private var infoGroup: some View {
        HStack(spacing: 12) {
            Circle()
                .frame(width: 61, height: 61)
                .foregroundStyle(.text2)
                .overlay {
                    Text("(프로필)")
                        .foregroundColor(.black)
                        .font(.pretendard(type: .light, size: 10))
                }
            
            VStack (alignment: .leading, spacing: 4){
                Text(nickName)
                    .font(.galmuri20)
                
                Text(verbatim: email) // 자동 링크 변환 막기
                    .font(.pretendardSemibold20)
                    .foregroundStyle(.black)
            }
            
            Spacer()
        }
        .padding(.horizontal, 19)
        .padding(.vertical, 40)
        .background(.lime2)
    }
    
    private var myReviewGroup: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("내가 쓴 리뷰")
                .font(.galmuri(size: 30))
            
            MyReviewSection(reviews: viewModel.MyReviews)
            
            Spacer()
        }
        .padding(.horizontal, 19)
        .padding(.vertical, 34)
        .background(.base)
    }
    
    // 내가 쓴 리뷰 섹션
    private func MyReviewSection(reviews: [ReviewModel]) -> some View {
        ForEach(reviews.indices, id: \.self) { index in
            VStack(alignment: .leading, spacing: 21) {
                HStack(spacing: 19) {
                    // 영화 이미지
                    Image(reviews[index].movieImage)
                        .resizable()
                        .frame(width: 94, height: 126)
                        .background(.perplexityBase)
                    
                    // 영화 텍스트
                    VStack(alignment: .leading, spacing: 10) {
                        VStack(alignment: .leading, spacing: 2) {
                            // 영화 제목
                            Text(reviews[index].movieTiTle)
                                .font(.pretendardMedium16)
                            
                            // 영화 평점
                            starIcon(rating: reviews[index].movieRating)
                        }
                        
                        // 영화 리뷰
                        Text(reviews[index].movieReview)
                            .font(.pretendardMedium16)
                    }
                }
            }
        }
    }
    
    // 영화 평점 별점 표시
    @ViewBuilder
    private func starIcon(rating: Int) -> some View {
        let fullStars: Int = rating
        
        HStack(spacing: 1) {
            ForEach(0..<5, id: \.self) { index in
                Text(index < rating ? "★" : "☆")
                    .font(.pretendardSemibold16)
            }
            
            Text(String(fullStars))
                .font(.pretendardSemibold16)
        }
    }
}

#Preview {
    MyPageView()
}
