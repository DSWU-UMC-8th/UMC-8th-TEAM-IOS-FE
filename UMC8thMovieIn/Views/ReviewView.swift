//
//  ReviewView.swift
//  UMC8thMovieIn
//
//  Created by 김미주 on 5/18/25.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
}

struct ReviewView: View {
    @State var rating = 0
    @State var text = ""
    
    var body: some View{
        VStack(spacing : 0) {
            recommendGroup
            
            postGroup
        }
    }
    
    private var recommendGroup : some View {
        VStack{
            HStack{
                Text("389")
                    .foregroundStyle(.white)
                    .font(.pretendardMedium12)
                Spacer()
                Text("389")
                    .foregroundStyle(.white)
                    .font(.pretendardMedium12)
            }
            GeometryReader{ geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .foregroundStyle(.point)
                    Rectangle()
                        .frame(width: geometry.size.width * 0.5)
                        .foregroundStyle(.lime2)
                }
            }
            .frame(height: 8)
            .border(.lime2, width: 1)
            
            HStack(spacing: 0){
                Button(action:{}, label: {
                    HStack{
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
                Button(action:{}, label: {
                    HStack{
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
                        Image(index <= rating ? .filledStar : .star)
                            .font(.largeTitle)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    rating = index
                                }
                            }
                    }
                }
                Spacer().frame(width: 15)
                Text("\(rating)")
                    .font(.galmuri20)
            }
            Spacer().frame(height: 20)
            
            ZStack{
                Rectangle()
                    .foregroundStyle(.lime2)
                    .cornerRadius(15)
                HStack{
                    TextField("리뷰를 작성해주세요!", text: $text)
                        .padding(.leading)
                    Button(action:{}, label: {
                        ZStack{
                            Rectangle()
                                .cornerRadius(15, corners: [.topRight, .bottomRight])
                                .foregroundStyle(.limeShade)
                            Text("등록")
                                .font(.pretendardSemibold16)
                                .foregroundStyle(.black)
                        }
                    })
                    .frame(width: 110)
                }
            }
            .frame(height: 50)
            
        }
        .frame(width: .infinity)
        .padding(.vertical, 21)
        .padding(.horizontal, 17.5)
        .background(.base)
    }
}

#Preview {
    ReviewView()
}
