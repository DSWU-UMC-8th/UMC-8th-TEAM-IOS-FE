//
//  PostModel.swift
//  UMC8thMovieIn
//
//  Created by 정서영 on 5/28/25.
//

import Foundation
import SwiftUI

struct PostModel: Codable, Equatable {
    var rating: Int = 0
    var content: String = ""
    var likeCount: Int = 365
    var dislikeCount: Int = 278
}

