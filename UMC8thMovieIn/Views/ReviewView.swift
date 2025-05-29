//
//  ReviewView.swift
//  UMC8thMovieIn
//
//  Created by 김미주 on 5/18/25.
//

import SwiftUI
import Kingfisher

struct ReviewView: View {
    @StateObject private var viewModel = PostViewModel()
    
    var body: some View{
        VStack(spacing : 0) {
            recommendGroup
            postGroup
        }
        .onChange(of: viewModel.submittedPost) { newPost in
            guard newPost != nil else { return }
            Task {
                await viewModel.fetchReviews(for: 1)
            }
        }
    }
    
    private var recommendGroup: some View {
        VStack {
            HStack {
                Text("\(viewModel.post.likeCount)")
                    .foregroundStyle(.white)
                    .font(.pretendardMedium12)
                Spacer()
                Text("\(viewModel.post.dislikeCount)")
                    .foregroundStyle(.white)
                    .font(.pretendardMedium12)
            }

            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .foregroundStyle(.point)
                    Rectangle()
                        .frame(width: geometry.size.width * viewModel.likeRatio)
                        .foregroundStyle(.lime2)
                }
            }
            .frame(height: 8)
            .border(.lime2, width: 1)

            HStack(spacing: 0) {
                Button(action: {
                    withAnimation(.easeInOut) {
                        viewModel.addLike()
                    }
                }, label: {
                    HStack {
                        Image(.up)
                        Text("추천!")
                            .font(.galmuri20)
                            .foregroundStyle(.black)
                    }
                })
                .frame(maxWidth: .infinity)
                .padding()
                .background(.lime2)
                .border(.perplexityBase, width: 1)

                Button(action: {
                    withAnimation(.easeInOut) {
                        viewModel.addDislike()
                    }
                }, label: {
                    HStack {
                        Image(.down)
                        Text("비추천..")
                            .font(.galmuri20)
                            .foregroundStyle(.black)
                    }
                })
                .frame(maxWidth: .infinity)
                .padding()
                .background(.lime2)
                .border(.perplexityBase, width: 1)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 12)
        .padding(.top, 17)
        .padding(.bottom, 36)
        .background(.point)
    }

    
    private var postGroup: some View {
        VStack(alignment: .leading){
            HStack{
                Image(.profile)
                Spacer().frame(width: 10)
                Text("나")
                    .font(.galmuri18)
                Spacer().frame(width: 20)
                HStack {
                    ForEach(1..<6) { index in
                        Image(index <= viewModel.rating ? .filledStar : .star)
                            .font(.largeTitle)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    viewModel.rating = index
                                }
                            }
                    }
                }
                Spacer().frame(width: 15)
                Text("\(viewModel.rating)")
                    .font(.galmuri20)
            }
            Spacer().frame(height: 20)
            
            if viewModel.isWritingReview{
                ZStack(alignment: .topLeading){
                    TextEditor(text: $viewModel.text)
                        .font(.pretendardMedium15)
                        .padding(.init(top: 8, leading: 8, bottom: 0, trailing: 0))
                        .frame(maxWidth: .infinity)
                        .frame(height: 256)
                        .scrollContentBackground(.hidden)
                        .background(.lime2)
                        .cornerRadius(15)
                    
                    if viewModel.text.isEmpty {
                        Text("리뷰를 작성해주세요!")
                            .font(.pretendardMedium15)
                            .padding(.init(top: 16, leading: 16, bottom: 0, trailing: 0))
                    }
                    
                    HStack{
                        Text("(\(viewModel.text.count)/100)")
                            .font(.pretendardMedium15)
                            
                        Spacer()
                        Text("스포일러 포함")
                            .font(.pretendardMedium12)
                        Image(viewModel.containsSpoiler ? "spoilerOn" : "spoilerOff")
                            .onTapGesture {
                                withAnimation {
                                    viewModel.containsSpoiler.toggle()
                                }
                            }
                        Spacer()
                        Button(action:{
                            Task {
                                await
                                viewModel.submitReview(movieID: 1, feelingTags: [1, 3, 5])
                                
                            }
                        }, label: {
                            ZStack{
                                Rectangle()
                                    .frame(width: 80, height: 33)
                                    .foregroundStyle(.limeShade)
                                Text("등록")
                            }
                        })
                    }
                    .padding(.init(top: 220, leading: 16, bottom: 0, trailing: 16))
                }
                .foregroundColor(.black)
            } else{
                Button(action:{
                    withAnimation {
                        viewModel.isWritingReview = true
                    }
                }, label: {
                    ZStack{
                        Rectangle()
                            .foregroundStyle(.lime2)
                            .cornerRadius(15)
                        HStack{
                            Text("리뷰를 작성해주세요!")
                                .font(.pretendardMedium15)
                                .foregroundStyle(.black)
                                .padding(.leading)
                            Spacer()
                        }
                    }
                })
                .frame(height: 50)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 21)
        .padding(.horizontal, 17.5)
        .background(.base)
    }
    

}

#Preview {
    ReviewView()
}
