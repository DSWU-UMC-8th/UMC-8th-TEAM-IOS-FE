//
//  MovieDetailViewModel.swift
//  UMC8thMovieIn
//
//  Created by 이채은 on 5/28/25.
//

import Foundation
import SwiftUI

@MainActor
final class MovieDetailViewModel: ObservableObject {
    @Published var movieDetail: MovieDetailModel?
    @Published var reviews: [MovieReview] = []
    @Published var errorMessage: String?

    //영화 상세 정보
    func loadMovieDetail(movieId: Int) async {
        do {
            let movieDTO = try await MovieService.shared.fetchMovieDetail(movieId: movieId)
            guard let movieInfo = movieDTO.result.reviews.first else {
                errorMessage = "영화 정보를 찾을 수 없습니다."
                return
            }
            movieDetail = mapToDetailModel(movieInfo: movieInfo)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    //영화 리뷰
    func loadReviews(movieId: Int, page: Int = 1, size: Int = 10) async {
            errorMessage = nil
            do {
                let response = try await MovieService.shared.fetchMovieReviews(movieId: movieId, page: page, size: size)
                if response.isSuccess {
                    reviews = response.result
                } else {
                    errorMessage = response.message
                }
            } catch {
                errorMessage = error.localizedDescription
            }
        }

    private func mapToDetailModel(movieInfo: MovieInfo) -> MovieDetailModel {
        let year = String(movieInfo.releaseDate.prefix(4))

        let hours = movieInfo.time / 60
        let minutes = movieInfo.time % 60
        var timeString = ""
        if hours > 0 {
            timeString += "\(hours)시간 "
        }
        if minutes > 0 {
            timeString += "\(minutes)분"
        }

        let scoreOutOfFive = Int(floor(Double(movieInfo.score) / 2.0))

        let ageString = "\(movieInfo.age)"

        return MovieDetailModel(
            movieId: movieInfo.movieId,
            movieName: movieInfo.moviename,
            releaseDate: year,
            age: ageString,
            time: timeString,
            content: movieInfo.content,
            director: movieInfo.director,
            score: scoreOutOfFive,
            actor: movieInfo.actor,
            movieImageURL: movieInfo.movieImage
        )
    }
}
