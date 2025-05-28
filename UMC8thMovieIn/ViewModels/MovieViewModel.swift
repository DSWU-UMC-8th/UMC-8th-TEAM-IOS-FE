//
//  MovieViewModel.swift
//  UMC8thMovieIn
//
//  Created by 김미주 on 5/18/25.
//

import Foundation
import Alamofire

@Observable
class MovieViewModel {
    var recommendMovies: [MovieModel] = []
    var nowplayingMovies: [MovieModel] = []
    var topratedMovies: [MovieModel] = []

    init() {
        fetchRecommendedMovies()
        fetchNowPlayingMovies()
        fetchTopRatedMovies()
    }

    func fetchRecommendedMovies() {
        let url = "http://52.78.195.123:3000/api/home/movies/recommended"

        AF.request(url)
            .validate()
            .responseDecodable(of: MovieResponse.self) { response in
                switch response.result {
                case .success(let movieResponse):
                    if movieResponse.isSuccess {
                        Task { @MainActor in
                            self.recommendMovies = movieResponse.result
                        }
                    }
                case .failure(let error):
                    print("영화 추천 API 실패: \(error.localizedDescription)")
                }
            }
    }
    
    func fetchNowPlayingMovies() {
        let url = "http://52.78.195.123:3000/api/home/movies/now-playing"
        
        AF.request(url)
            .validate()
            .responseDecodable(of: MovieResponse.self) { response in
                switch response.result {
                case .success(let movieResponse):
                    if movieResponse.isSuccess {
                        Task { @MainActor in
                            self.nowplayingMovies = movieResponse.result
                        }
                    }
                case .failure(let error):
                    print("현재 상영작 API 실패: \(error.localizedDescription)")
                }
            }
    }
    
    func fetchTopRatedMovies() {
        let url = "http://52.78.195.123:3000/api/home/movies/top-rated"
        
        AF.request(url)
            .validate()
            .responseDecodable(of: MovieResponse.self) { response in
                switch response.result {
                case .success(let movieResponse):
                    if movieResponse.isSuccess {
                        Task { @MainActor in
                            self.topratedMovies = movieResponse.result
                        }
                    }
                case .failure(let error):
                    print("현재 상영작 API 실패: \(error.localizedDescription)")
                }
            }
    }
}
