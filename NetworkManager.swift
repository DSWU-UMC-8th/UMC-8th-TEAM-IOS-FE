//
//  NetworkManager.swift
//  UMC8thMovieIn
//
//  Created by Jung Hyun Han on 5/25/25.
//

import Foundation

struct User: Codable {
    let userId: Int
    let username: String
    let email: String
    let nickname: String
}

struct LoginResponse: Codable {
    let isSuccess: String
    let code: String
    let message: String
    let token: String
    let result: User
}

struct SignupResponse: Codable {
    let isSuccess: String
    let code: String
    let message: String
    let result: User
}

struct CheckUsernameResponse: Codable {
    let isSuccess: String
    let code: String
    let message: String
}

struct ServerError: Codable {
    let error: String
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    private let baseURL = "http://52.78.195.123:3000"

    
     func login(username: String, password: String, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        request(endpoint: "/api/login", method: "POST", body: [
            "username": username,
            "password": password
        ], completion: completion)
    }

    func register(username: String, password: String, email: String, nickname: String, completion: @escaping (Result<SignupResponse, Error>) -> Void) {
        request(endpoint: "/api/register", method: "POST", body: [
            "username": username,
            "password": password,
            "passwordConfirm": password,
            "email": email,
            "nickname": nickname
        ], completion: completion)
    }

    func checkUsername(_ username: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/api/check-id?username=\(username)") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error { completion(.failure(error)); return }
            guard let data = data else { return }
            
            print("Raw Response: \(String(data: data, encoding: .utf8) ?? "nil")")

            do {
                let decoded = try JSONDecoder().decode(CheckUsernameResponse.self, from: data)
                completion(.success(decoded.message == "사용 가능한 아이디입니다."))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    private func request<T: Decodable>(endpoint: String, method: String, body: [String: String], completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: baseURL + endpoint) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error { completion(.failure(error)); return }
            guard let data = data else { return }

            if let decoded = try? JSONDecoder().decode(T.self, from: data) {
                completion(.success(decoded))
            } else if let serverError = try? JSONDecoder().decode(ServerError.self, from: data) {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: serverError.error])))
            } else {
                let raw = String(data: data, encoding: .utf8) ?? "no response"
                print("Unhandled response: \(raw)")
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unknown Error"])))
            }
        }.resume()
    }
}
