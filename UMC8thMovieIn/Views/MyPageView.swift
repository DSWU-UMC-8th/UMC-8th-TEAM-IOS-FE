//
//  MyPageView.swift
//  UMC8thMovieIn
//
//  Created by 신연주 on 5/18/25.
//

import SwiftUI
import Kingfisher

struct MyPageView: View {
    @StateObject private var reviewViewModel = MyReviewViewModel()
    @StateObject private var userViewModel = UserViewModel()
    //@AppStorage("nickname") private var nickname: String = "닉네임"
    //@AppStorage("email") private var email: String = "email@naver.com"
    @AppStorage("userId") private var userId: Int = 25
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack (spacing: 0){
            TopGroup
            
            infoGroup(userInfo: userViewModel.userInfo)
            
            myReviewGroup
        }
        .task {
                await reviewViewModel.fetchMyReview(userId: userId)
                await userViewModel.fetchUserInfo(userId: userId)
        }
        .navigationBarBackButtonHidden()
    }
    
    //상단 바
    private var TopGroup: some View {
        ZStack {
            Text("마이페이지")
                .font(.galmuri20)
                .foregroundStyle(.black)
            HStack(){
                Button(action: {
                    dismiss()
                }) {
                    Image(.logo)
                        .resizable()
                        .frame(width: 34, height: 34)
                }
                
                Spacer()
            }
            .padding(.horizontal, 13.5)
        }
        .padding(.top, 5)
        .padding(.bottom, 14)
        .frame(maxWidth: .infinity)
        .background(.limeShade)
    }
    
    private func infoGroup(userInfo: UserInfoModel?) -> some View {
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
                if let userInfo = userViewModel.userInfo {
                                    Text(userInfo.nickname)
                                        .font(.galmuri20)

                                    Text(verbatim: userInfo.email)
                                        .font(.pretendardSemibold20)
                                        .foregroundStyle(.black)
                                }
                else {
                                    Text("사용자 정보를 불러올 수 없습니다.")
                                        .foregroundColor(.red)
                                }
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
                .frame(maxWidth: .infinity, alignment: .leading)
            
            MyReviewSection(myReviews: reviewViewModel.myReviews)
            
            Spacer()
        }
        .padding(.horizontal, 19)
        .padding(.top, 34)
        .frame(maxWidth: .infinity)
        .background(.base)
    }
    
    
    // 내가 쓴 리뷰 섹션
    private func MyReviewSection(myReviews: [MyReviewModel]) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 21) {
                ForEach(myReviews, id: \.reviewId) { review in
                    ReviewCard(review: review)
                }
            }
            //.padding(.horizontal, 16)
            .frame(maxWidth: .infinity)
        }
    }
}

struct ReviewCard: View {
    let review: MyReviewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 21) {
            HStack(spacing: 19) {
                // 영화 이미지
                KFImage(URL(string: review.movieImage))
                    .resizable()
                    .frame(width: 94, height: 126)
                    .background(.perplexityBase)
                
                // 영화 텍스트
                VStack(alignment: .leading, spacing: 10) {
                    VStack(alignment: .leading, spacing: 2) {
                        // 영화 제목
                        Text(review.movieTitle)
                            .font(.pretendardMedium16)
                        
                        // 영화 평점
                        starIcon(rating: review.rating)
                    }
                    
                    // 영화 리뷰
                    Text(review.content)
                        .font(.pretendardMedium16)
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
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
