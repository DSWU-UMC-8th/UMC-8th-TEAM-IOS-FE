//
//  SignupView.swift
//  UMC8thMovieIn
//
//  Created by 김미주 on 5/18/25.
//

import SwiftUI

struct SignupView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var userId = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var email = ""
    @State private var nickname = ""

    @State private var isUserIdAvailable: Bool? = nil
    @State private var showValidation = false
    @State private var signupErrorMessage: String? = nil

    @State private var selectedDomain: String = "직접입력"
    let emailDomains = ["직접입력", "gmail.com", "naver.com", "daum.net"]

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: 0) {
                    Rectangle()
                        .frame(height: 40)
                        .foregroundStyle(.standard)
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            Image("menu")
                        }
                        Spacer()
                        Text("회원가입")
                            .font(.galmuri20)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.horizontal, 40)
                    .padding(.vertical, 30)
                    .background(Color("standard"))
                    .navigationBarBackButtonHidden(true)

                    Spacer()

                    VStack (spacing: 50) {
                        VStack(spacing: 20){
                            VStack(alignment: .leading, spacing: 10){
                                Text("아이디").font(.galmuri20)
                                HStack(spacing: 0) {
                                    TextField("아이디", text: $userId)
                                        .font(.pretendardMedium15)
                                        .textFieldStyle(LimeTextFieldStyle())
                                        .autocapitalization(.none)
                                        .disableAutocorrection(true)
                                    Button(action: {
                                        showValidation = true
                                        if userId.count < 4 || userId.count > 12 {
                                            isUserIdAvailable = nil
                                        } else {
                                            NetworkManager.shared.checkUsername(userId) { result in
                                                DispatchQueue.main.async {
                                                    switch result {
                                                    case .success(let isAvailable):
                                                        isUserIdAvailable = isAvailable
                                                    case .failure(let error):
                                                        isUserIdAvailable = nil
                                                        print("[중복확인 오류] \(error.localizedDescription)")
                                                    }
                                                }
                                            }
                                        }
                                    }) {
                                        Text("중복확인")
                                            .font(.pretendardSemibold16)
                                            .foregroundStyle(Color.black)
                                            .frame(width: 120, height: 50)
                                            .background(Color("limeShade"))
                                            .cornerRadius(10)
                                    }
                                }

                                if showValidation {
                                    if userId.count < 4 || userId.count > 12 {
                                        Text("영어와 숫자를 사용하여 4~12자의 아이디를 입력해주세요.")
                                            .font(.pretendardRegular14)
                                    } else if isUserIdAvailable == false {
                                        Text("중복된 아이디입니다.")
                                            .font(.pretendardRegular14)
                                    } else if isUserIdAvailable == true {
                                        Text("사용 가능한 아이디입니다.")
                                            .font(.pretendardRegular14)
                                    }
                                }
                            }

                            VStack(alignment: .leading, spacing: 10) {
                                Text("비밀번호").font(.galmuri20)
                                SecureField("비밀번호", text: $password)
                                    .font(.pretendardMedium15)
                                    .textFieldStyle(LimeTextFieldStyle())
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                if showValidation && !isPasswordValid {
                                    Text("영어와 숫자, 특수문자를 조합하여 6~20자로 입력해주세요.")
                                        .font(.pretendardRegular14)
                                }
                                SecureField("비밀번호 확인", text: $confirmPassword)
                                    .font(.pretendardMedium15)
                                    .textFieldStyle(LimeTextFieldStyle())
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                if showValidation && password != confirmPassword {
                                    Text("비밀번호가 일치하지 않습니다.")
                                        .font(.pretendardRegular14)
                                }
                            }

                            VStack(alignment: .leading, spacing: 10) {
                                Text("이메일").font(.galmuri20)
                                HStack(spacing: 0) {
                                    TextField("이메일", text: $email)
                                        .font(.pretendardMedium15)
                                        .textFieldStyle(LimeTextFieldStyle())
                                        .autocapitalization(.none)
                                        .disableAutocorrection(true)
                                    Menu {
                                        ForEach(emailDomains, id: \.self) { domain in
                                            Button(domain) {
                                                selectedDomain = domain
                                                if domain != "직접입력" {
                                                    email = email.split(separator: "@").first.map { "\($0)@\(domain)" } ?? ""
                                                }
                                            }
                                        }
                                    } label: {
                                        HStack(spacing: 6) {
                                            Text(selectedDomain).font(.pretendardSemibold16).foregroundColor(.black)
                                            Image("Vector")
                                        }
                                        .frame(width: 120, height: 50)
                                        .background(Color("limeShade"))
                                        .cornerRadius(10)
                                    }
                                }
                            }

                            VStack(alignment: .leading, spacing: 10) {
                                Text("닉네임").font(.galmuri20)
                                TextField("ex) 팝콘먹는 자라", text: $nickname)
                                    .font(.pretendardMedium15)
                                    .textFieldStyle(LimeTextFieldStyle())
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                if showValidation && nickname.count > 12 {
                                    Text("12자 이내로 입력해주세요.").font(.pretendardRegular14)
                                }
                            }
                        }
                        .padding()

                        if let error = signupErrorMessage {
                            Text(error).font(.pretendardRegular14)
                        }

                        Spacer()
                    }
                }
            }

            Button {
                showValidation = true
                if isPasswordValid && password == confirmPassword {
                    NetworkManager.shared.register(username: userId, password: password, email: email, nickname: nickname) { result in
                        DispatchQueue.main.async {
                            switch result {
                            case .success:
                                dismiss()
                            case .failure(let err):
                                signupErrorMessage = err.localizedDescription
                            }
                        }
                    }
                }
            } label: {
                Text("가입하기")
                    .font(.galmuri20)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 60)
                    .background(Color("point"))
            }
        }
        .background(Color("base"))
        .ignoresSafeArea()
    }

    var isPasswordValid: Bool {
        password.count >= 6 && password.count <= 20
    }
}

struct LimeTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .padding()
            .frame(height: 50)
            .background(Color("lime2"))
            .foregroundColor(.black)
            .cornerRadius(10)
    }
}

#Preview {
    SignupView()
}
