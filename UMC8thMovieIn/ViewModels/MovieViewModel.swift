//
//  MovieViewModel.swift
//  UMC8thMovieIn
//
//  Created by 김미주 on 5/18/25.
//

import Foundation
import SwiftUI

@Observable
class MovieViewModel {
    let recommendMovies: [MovieModel] = [
        .init(movieImage: .init(""), movieName: "추천영화1"),
        .init(movieImage: .init(""), movieName: "추천영화2"),
        .init(movieImage: .init(""), movieName: "추천영화3"),
        .init(movieImage: .init(""), movieName: "추천영화4"),
        .init(movieImage: .init(""), movieName: "추천영화5"),
        .init(movieImage: .init(""), movieName: "추천영화6"),
    ]
    
    let recentMovies: [MovieModel] = [
        .init(movieImage: .init(""), movieName: "최신영화1"),
        .init(movieImage: .init(""), movieName: "최신영화2"),
        .init(movieImage: .init(""), movieName: "최신영화3"),
        .init(movieImage: .init(""), movieName: "최신영화4"),
        .init(movieImage: .init(""), movieName: "최신영화5"),
        .init(movieImage: .init(""), movieName: "최신영화6"),
    ]
    
    let reviewMovies: [MovieModel] = [
        .init(movieImage: .init(""), movieName: "리뷰좋은영화1"),
        .init(movieImage: .init(""), movieName: "리뷰좋은영화2"),
        .init(movieImage: .init(""), movieName: "리뷰좋은영화3"),
        .init(movieImage: .init(""), movieName: "리뷰좋은영화4"),
        .init(movieImage: .init(""), movieName: "리뷰좋은영화5"),
        .init(movieImage: .init(""), movieName: "리뷰좋은영화6"),
    ]
}
