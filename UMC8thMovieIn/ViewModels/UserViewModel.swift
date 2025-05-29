//
//  UserViewModel.swift
//  UMC8thMovieIn
//
//  Created by 신연주 on 5/28/25.
//

import Foundation
import SwiftUI

@MainActor
class UserViewModel: ObservableObject {
    @Published var userInfo: UserInfoModel? = nil
    @Published var errorMessage: String?
    
    
    func fetchUserInfo(userId: Int) async {
        do {
            let response = try await APIClient.shared.fetchUserInfo(userId: userId)
            if response.isSuccess {
                userInfo = response.result
                errorMessage = nil
            } else {
                errorMessage = response.message
                print("[❌ API 실패] 서버 응답 메시지: \(response.message)")
            }
        } catch {
            self.errorMessage = error.localizedDescription
            print("[❌ 네트워크 에러] \(error.localizedDescription)")
        }
    }
}
