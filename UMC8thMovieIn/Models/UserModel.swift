//
//  UserInfoModel.swift
//  UMC8thMovieIn
//
//  Created by 신연주 on 5/28/25.
//

import Foundation
import SwiftUI

struct UserInfoResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: UserInfoModel
}

struct UserInfoModel: Decodable {
    let userId: Int
    let username: String
    let email: String
    let nickname: String
}
