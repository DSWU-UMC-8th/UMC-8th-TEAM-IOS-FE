//
//  APIClient.swift
//  UMC8thMovieIn
//
//  Created by 신연주 on 5/27/25.
//

import Foundation
import Alamofire

class APIClient {
    static let shared = APIClient()
    private init() {}
    
    private let session: Session = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10
        return Session(configuration: config)
    }()
    
    private let baseURL = "http://52.78.195.123:3000"
    
    
    // 마이페이지 나의 리뷰 API
    func fetchMyReview(userId: Int) async throws -> MyReviewResponse {
        let url = "\(baseURL)/api/users/\(userId)/reviews"
        
        print("[DEBUG] 요청 URL: \(url)")
        return try await session.request(url, method: .get)
            .validate()
            .serializingDecodable(MyReviewResponse.self)
            .value
    }
    
    // 마이페이지 사용자 정보 조회 API
    func fetchUserInfo(userId: Int) async throws -> UserInfoResponse {
        let url = "\(baseURL)/api/users/\(userId)"
        
        print("[DEBUG] 요청 URL: \(url)")
        return try await session.request(url, method: .get)
            .validate()
            .serializingDecodable(UserInfoResponse.self)
            .value
    }
}
