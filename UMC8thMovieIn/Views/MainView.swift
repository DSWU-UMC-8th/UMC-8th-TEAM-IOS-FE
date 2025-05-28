//
//  MainView.swift
//  UMC8thMovieIn
//
//  Created by 김미주 on 5/18/25.
//

import SwiftUI
import Kingfisher

enum Route: Hashable {
    case movieDetail(id: Int)
    case myPage
}

struct MainView: View {
    @State private var viewModel = MovieViewModel()
    @State private var selectedRoute: Route? = nil

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                TopView
                MovieView
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    private var TopView: some View {
        HStack(spacing: 9) {
            Text("Movie In")
                .font(.pixelifySemiBold30)
            
            Image(.logo)
            
            Spacer()
            
            NavigationLink(destination: MyPageView()){
                Image(.myPixel)
                    .resizable()
                    .frame(width: 34, height: 34)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(.limeShade)
    }
    
    private var MovieView: some View {
        VStack(alignment: .leading, spacing: 33) {
            movieSection(title: "오늘의 추천 영화", movies: viewModel.recommendMovies)
            movieSection(title: "최근 개봉한 영화", movies: viewModel.nowplayingMovies)
            movieSection(title: "평점 높은 영화", movies: viewModel.topratedMovies)
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
                    ForEach(movies) { movie in
                        NavigationLink(destination: MovieDetailView(movieId: movie.id)){
                            MovieCard(movie: movie)
                        }
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
        VStack(alignment: .leading) {
            KFImage(URL(string: movie.posterUrl))
                .placeholder { ProgressView() }
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 94, height: 126)
                .clipped()

            Text(movie.title)
                .font(.pretendardMedium16)
                .foregroundStyle(.black)
                .lineLimit(1)
        }
        .frame(width: 94)
    }
}

#Preview {
    MainView()
}
