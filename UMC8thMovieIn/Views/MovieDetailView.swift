//
//  MovieDetailView.swift
//  UMC8thMovieIn
//
//  Created by 김미주 on 5/18/25.
//

import SwiftUI
import Kingfisher

struct MovieDetailView: View {
    @StateObject private var viewModel = MovieDetailViewModel()
    let movieId: Int
    
    @State private var selectedOption: String? = nil
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0){
                TopGroup
                ScrollView{
                    VStack(spacing: 0) {
                        if let detail = viewModel.movieDetail {
                            MovieInfoGroup(detail: detail)
                        } else if let error = viewModel.errorMessage {
                            Text(error)
                                .foregroundColor(.red)
                                .padding()
                            Spacer()
                        } else {
                            ProgressView()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        ReviewTitleGroup
                        OptionGroup
                        ReviewGroup
                        Spacer()
                    }
                    .task {
                        await viewModel.loadMovieDetail(movieId: movieId)
                        await viewModel.loadReviews(movieId: movieId)
                    }
                }
                .ignoresSafeArea()
                .scrollIndicators(.hidden)
                .background(.base)
            }
        }
        .navigationBarBackButtonHidden()
        
    }
    
    //상단 바
    private var TopGroup: some View {
        VStack {
            HStack(spacing: 115){
                NavigationLink(destination: MainView()){
                    Image(.logo)
                        .resizable()
                        .frame(width: 34, height: 34)
                }
                Text(viewModel.movieDetail?.movieName ?? "영화 이름")
                    .font(.galmuri20)
                NavigationLink(destination: MyPageView()){
                    Image(.myPixel)
                        .resizable()
                        .frame(width: 34, height: 34)
                }
            }
        }
        .padding(.top, 5)
        .padding(.bottom, 14)
        .frame(maxWidth: .infinity)
        .background(.limeShade)
    }
    
    //영화 정보
    private func MovieInfoGroup(detail: MovieDetailModel) -> some View {
        VStack(alignment: .leading){
            //영화 상세 이미지
            KFImage(URL(string: detail.movieImageURL))
                .placeholder {
                    ProgressView()
                }
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 400, height: 234)
            
            Spacer().frame(height: 24)
            
            VStack(alignment: .leading) {
                //영화 이름
                Text(detail.movieName)
                    .font(.pretendardSemibold20)
                Spacer().frame(height: 2.5)
                
                //영화 평점
                HStack(spacing: 5){
                    HStack(spacing: 3){
                        ForEach(0..<5) { index in
                            Image(index < detail.score ? .fillStar : .emptyStar)
                        }
                    }
                    Spacer().frame(width: 3)
                    Text("\(detail.score)")
                        .font(.galmuri20)
                }
                
                Spacer().frame(height: 10)
                
                //영화 정보
                HStack(spacing: 5){
                    Text(detail.releaseDate)
                        .font(.pretendardMedium15)
                    Text("[\(detail.age)]")
                        .font(.pretendardMedium15)
                    Text(detail.time)
                        .font(.pretendardMedium15)
                }
                
                Spacer().frame(height: 15)
                
                //영화 줄거리
                Text(detail.content)
                    .font(.pretendardMedium12)
                
                Spacer().frame(height: 22)
                
                //영화 출연진
                HStack(spacing: 5){
                    Text("출연")
                        .font(.pretendardMedium12)
                    Text(detail.actor)
                        .font(.pretendardMedium12)
                }
                
                //영화 감독
                HStack(spacing: 5){
                    Text("감독")
                        .font(.pretendardMedium12)
                    Text(detail.director)
                        .font(.pretendardMedium12)
                }
                
                Spacer().frame(height: 20)
            }
            .padding(.horizontal, 23)
        }
        .frame(maxWidth: .infinity)
        .background(.base)
    }
    
    //리뷰 타이틀
    private var ReviewTitleGroup: some View {
        VStack(alignment: .leading) {
            Text("리뷰")
                .font(.galmuri20)
        }
        .frame(maxWidth: .infinity, minHeight: 50, alignment: .leading)
        .padding(.leading, 26)
        .background(.base)
    }
    
    //리뷰 높은ㅅ순/낮은 순
    private var OptionGroup: some View {
        HStack(spacing: 1) {
            Button(action: {
                selectedOption = "높은 순"
                print("높은 순")
            }) {
                ZStack {
                    Rectangle()
                        .frame(width: 50, height: 24)
                        .foregroundStyle(selectedOption == "높은 순" ? .base : .text2)
                    Text("높은 순")
                        .font(.pretendardMedium12)
                        .foregroundStyle(.white)
                }
            }
            
            Button(action: {
                selectedOption = "낮은 순"
                print("낮은 순")
            }) {
                ZStack {
                    Rectangle()
                        .frame(width: 50, height: 24)
                        .foregroundStyle(selectedOption == "낮은 순" ? .base : .text2)
                    Text("낮은 순")
                        .font(.pretendardMedium12)
                        .foregroundStyle(.white)
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, minHeight: 45)
        .padding([.leading, .trailing], 22)
        .background(.limeShade)
    }
    
    //리뷰 목록
    private var ReviewGroup: some View {
        VStack(alignment: .leading){
            ForEach(viewModel.reviews) { review in
                VStack(alignment: .leading){
                    HStack(spacing: 12){
                        Circle()
                            .frame(width: 32, height: 32)
                        Text(review.nickname)
                            .font(.galmuri15)
                        HStack(spacing: 5){
                            HStack(spacing: 3){
                                ForEach(0..<5) { index in
                                    Image(index < review.starRating ? .fillStar : .emptyStar)
                                }
                            }
                            Spacer().frame(width: 3)
                            Text("\(review.starRating)")
                                .font(.galmuri20)
                        }
                    }
                    
                    Spacer().frame(height: 13)
                    
                    Text(review.content)
                        .font(.pretendardMedium12)
                    
                    Spacer().frame(height: 22)
                }
                .padding(.horizontal, 25)
                .padding(.top, 22)
                
                Divider()
                    .frame(height: 1, alignment: .bottom)
                    .overlay(.point)
            }
        }
        .background(.lime2)
    }
}

#Preview {
    MovieDetailView(movieId: 1)
}
