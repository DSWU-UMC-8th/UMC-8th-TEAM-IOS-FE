//
//  MainView.swift
//  UMC8thMovieIn
//
//  Created by 김미주 on 5/18/25.
//

import SwiftUI

struct MainView: View {
    @State private var viewModel = MovieViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            TopView
            MainView
        }
    }
    
    private var TopView: some View {
        HStack(spacing: 9) {
            Text("Movie In")
                .font(.pixelifySemiBold30)
            
            Image(.logo)
            
            Spacer()
            
            Button(action: {}) {
                // 임시
                Circle()
                    .frame(width: 43, height: 43)
                    .foregroundStyle(.base)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(.limeShade)
    }
    
    private var MainView: some View {
        VStack(alignment: .leading, spacing: 33) {
            movieSection(title: "오늘의 추천 영화", movies: viewModel.recommendMovies)
            movieSection(title: "최근 개봉한 영화", movies: viewModel.recentMovies)
            movieSection(title: "리뷰가 좋은 영화", movies: viewModel.reviewMovies)
        }
        .padding(.top, 37)
        .background(.base)
    }
    
    private func movieSection(title: String, movies: [MovieModel]) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.pretendardBold22)
                .padding(.horizontal, 16)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 18) {
                    ForEach(movies.indices, id: \.self) { index in
                        MovieCard(movie: movies[index])
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

struct MovieCard: View {
    let movie: MovieModel
    
    var body: some View {
        Button(action: {
            print("선택된 영화: \(movie.movieName)")
        }) {
            VStack(alignment: .leading) {
                // 임시
                movie.movieImage
                    .resizable()
                    .frame(width: 94, height: 126)
                    .background(.gray)
                
                Text(movie.movieName)
                    .font(.pretendardMedium16)
                    .foregroundStyle(.black)
                    .lineLimit(1)
            }
            .frame(width: 94)
        }
    }
}

#Preview {
    MainView()
}
