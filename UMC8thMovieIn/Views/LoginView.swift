//
//  LoginView.swift
//  UMC8thMovieIn
//
//  Created by 김미주 on 5/18/25.
//

import SwiftUI

struct LoginView: View {
    @State private var userId: String = ""
    @State private var password: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isLoggedIn = false
    @AppStorage("token") var token: String = ""
    @AppStorage("userId") private var storedUserId: Int = -1
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                
                // 로고
                HStack(spacing: 9){
                    Text("Movie In")
                        .font(.pixelifySemiBold45)
                    
                    Image("logo")
                        .resizable()
                        .frame(width: 48, height: 48)
                }
                .padding(.bottom, 30)
                
                VStack(spacing: 10) {
                    // 아이디 입력
                    TextField("아이디 입력", text: $userId)
                        .padding(.horizontal)
                        .frame(width: 320, height: 50)
                        .background(Color("lime2"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .textInputAutocapitalization(.never)
                    
                    // 비밀번호 입력
                    SecureField("비밀번호 입력", text: $password)
                        .padding(.horizontal)
                        .frame(width: 320, height: 50)
                        .background(Color("lime2"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                // 로그인 버튼
                ZStack{
                    Button(action: {
                        login()
                    }) {
                        Text("로그인")
                            .foregroundColor(.white)
                            .font(.pretendardBold22)
                            .frame(width: 320, height: 60)
                            .background(Color("standard"))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                    }
                }
                
                // 하단 텍스트
                HStack {
                    Text("무비인이 처음이신가요?")
                    Spacer()
                    NavigationLink(destination: SignupView()) {
                        Text("회원가입하기")
                            .underline()
                            .font(.pretendardSemibold14)
                    }
                }
                .padding(.horizontal, 45)
                .foregroundStyle(Color(.black))
                .font(.pretendardSemibold14)
                
                Spacer()
                
            }
            .background(Color("base"))
            .alert("로그인 실패", isPresented: $showAlert) {
                Button("확인", role: .cancel) {}
            } message: {
                Text(alertMessage)
            }
            
            .navigationDestination(isPresented: $isLoggedIn) {
                MainView()
            }
        }}
        
        func login() {
            NetworkManager.shared.login(username: userId, password: password) { result in
                switch result {
                case .success(let res):
                    DispatchQueue.main.async {
                        self.token = res.token
                        self.isLoggedIn = true
                        self.storedUserId = res.result.userId // AppStorage에 userId 저장
                    }
                    print(res.result.userId)
                case .failure(let err):
                    DispatchQueue.main.async {
                        self.alertMessage = err.localizedDescription
                        self.showAlert = true
                    }
                }
            }
        }
    }


#Preview {
    LoginView()
}
