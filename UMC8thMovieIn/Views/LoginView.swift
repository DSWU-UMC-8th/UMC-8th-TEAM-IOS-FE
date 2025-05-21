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
    
    var body: some View {
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
                
                // 비밀번호 입력
                SecureField("비밀번호 입력", text: $password)
                    .padding(.horizontal)
                    .frame(width: 320, height: 50)
                    .background(Color("lime2"))
            }
            
            // 로그인 버튼
            ZStack{
                Image("login-btn")
                Button(action: {
                    print("로그인 시도")
                }) {
                    Text("로그인")
                        .foregroundColor(.white)
                        .font(.pretendardBold22)
                        .frame(width: 320, height: 60)
                        .background(Color("standard"))
                    
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
    }
}

#Preview {
    LoginView()
}
