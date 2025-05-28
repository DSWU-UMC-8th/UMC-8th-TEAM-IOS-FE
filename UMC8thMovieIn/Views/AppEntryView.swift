//
//  AppEntryView.swift
//  UMC8thMovieIn
//
//  Created by 김미주 on 5/29/25.
//

import SwiftUI

struct AppEntryView: View {
    @AppStorage("token") var token: String = ""

    var body: some View {
        if token.isEmpty {
            LoginView()
        } else {
            MainView()
        }
    }
}
