//
//  MovieDetailView.swift
//  UMC8thMovieIn
//
//  Created by 김미주 on 5/18/25.
//

import SwiftUI

struct MovieDetailView: View {
    @State private var selectedOption: String? = nil
    @State private var starScore: Int = 3
    
    
    var body: some View {
        NavigationStack {
            VStack(spacing:0){
                TopGroup
                MovieInfoGroup
                OptionGroup
                ReviewGroup
                Spacer()
            }
        }
    }
    
    private var TopGroup: some View {
        VStack {
            HStack(spacing: 100){
                NavigationLink(destination: MainView()){
                    Image(.logo)
                        .resizable()
                        .frame(width: 34, height: 34)
                }
                Text("영화 이름")
                    .font(.galmuri20)
                Button(action: {
                    
                }) {
                    NavigationLink(destination: MyPageView()){
                        Circle()
                            .frame(width: 32, height: 32)
                            .foregroundColor(.base)
                    }
                }
            }
        }
        .padding(.top, 5)
        .padding(.bottom, 14)
        .frame(maxWidth: .infinity)
        .background(.limeShade)
    }
    
    private var MovieInfoGroup: some View {
        
        VStack(alignment: .leading){
            Image(.logo)
                .resizable()
                .frame(width: 400, height: 234, alignment: .center)
                .aspectRatio(contentMode: .fit)
                .background()
            Spacer().frame(height: 24)
            
            VStack(alignment: .leading) {
                Text("영화 이름")
                    .font(.pretendardSemibold20)
                Spacer().frame(height: 2.5)
                
                HStack(spacing: 5){
                    HStack(spacing: 3){
                        ForEach(0..<5) { index in
                            Image(index < starScore ? .fillStar : .emptyStar)
                        }
                    }
                    Spacer().frame(width: 3)
                    Text("\(starScore)")
                        .font(.galmuri20)
                }
                
                Spacer().frame(height: 10)
                
                HStack(spacing: 5){
                    Text("연도")
                        .font(.pretendardMedium15)
                    Text("[나이]")
                        .font(.pretendardMedium15)
                    Text("영화 길이")
                        .font(.pretendardMedium15)
                }
                
                Spacer().frame(height: 15)
                
                Text("영화 내용 요약 영화 내용 요약영화 내용 요약영화 내용 요약영화 내용 요약영화 내용 요약영화 내용 요약영화 내용 요약영화 내용 요약영화 내용 요약영화 내용 요약영화 내용")
                    .frame(width: 320)
                    .font(.pretendardMedium12)
                
                Spacer().frame(height: 22)
                
                Text("출연진")
                    .font(.pretendardMedium12)
                Text("감독")
                    .font(.pretendardMedium12)
                
                Spacer().frame(height: 20)
            }
            .padding(.horizontal, 23)
                
        }
        .frame(maxWidth: .infinity)
        .background(.base)
    }
    
    private var OptionGroup: some View {
        HStack(spacing: 1) {
            Button(action: {
                selectedOption = "높은 순"
                print("높은 순")
            }) {
                ZStack {
                    Rectangle()
                        .frame(width: 50, height: 24)
                        .foregroundStyle(selectedOption == "높은 순" ? .base : .text2)
                    Text("높은 순")
                        .font(.pretendardMedium12)
                        .foregroundStyle(.white)
                }
            }

            Button(action: {
                selectedOption = "낮은 순"
                print("낮은 순")
            }) {
                ZStack {
                    Rectangle()
                        .frame(width: 50, height: 24)
                        .foregroundStyle(selectedOption == "낮은 순" ? .base : .text2)
                    Text("낮은 순")
                        .font(.pretendardMedium12)
                        .foregroundStyle(.white)
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, minHeight: 45)
        .padding([.leading, .trailing], 22)
        .background(.limeShade)
    }
    
    private var ReviewGroup: some View {
        VStack(alignment: .leading){
            VStack(alignment: .leading){
                HStack(spacing: 12){
                    Circle()
                        .frame(width: 32, height: 32)
                    Text("사용자 이름")
                        .font(.galmuri15)
                    HStack(spacing: 5){
                        HStack(spacing: 3){
                            ForEach(0..<5) { index in
                                Image(index < starScore ? .fillStar : .emptyStar)
                            }
                        }
                        Spacer().frame(width: 3)
                        Text("\(starScore)")
                            .font(.galmuri20)
                    }
                }
                
                Spacer().frame(height: 13)
                
                Text("리뷰 내용")
                    .font(.pretendardMedium12)
                
                Spacer().frame(height: 13)
            }
            .padding(.horizontal, 25)
            
            Divider()
                .frame(height: 1, alignment: .bottom)
                .overlay(.point)
            
        }
        .padding(.top, 22)
        .background(.lime2)
    }

}

#Preview {
    MovieDetailView()
}
