//
//  Font.swift
//  UMC8thMovieIn
//
//  Created by 김미주 on 5/18/25.
//

import Foundation
import SwiftUI

extension Font {
    // MARK: - PixelifySans
    enum PixelifySans {
        case bold
        case semibold
        case medium
        case regular
        
        var value: String {
            switch self {
            case .bold:
                return "PixelifySans-Bold"
            case .semibold:
                return "PixelifySans-SemiBold"
            case .medium:
                return "PixelifySans-Medium"
            case .regular:
                return "PixelifySans-Regular"
            }
        }
    }
    
    static func pixelifySans(type: PixelifySans, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
    
    static var pixelifySemiBold45: Font {
        return .pixelifySans(type: .semibold, size: 45)
    }
    
    static var pixelifySemiBold30: Font {
        return .pixelifySans(type: .semibold, size: 30)
    }
    
    // MARK: - Pretendard
    enum Pretendard {
        case regular
        case thin
        case extralight
        case light
        case medium
        case semibold
        case bold
        case extrabold
        case black

        var value: String {
            switch self {
            case .regular: return "PretendardVariable-Regular"
            case .thin: return "PretendardVariable-Thin"
            case .extralight: return "PretendardVariable-ExtraLight"
            case .light: return "PretendardVariable-Light"
            case .medium: return "PretendardVariable-Medium"
            case .semibold: return "PretendardVariable-SemiBold"
            case .bold: return "PretendardVariable-Bold"
            case .extrabold: return "PretendardVariable-ExtraBold"
            case .black: return "PretendardVariable-Black"
            }
        }
    }
    
    static func pretendard(type: Pretendard, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
    
    static var pretendardBold22: Font {
        return .pretendard(type: .bold, size: 22)
    }
    
    static var pretendardSemibold20: Font {
        return .pretendard(type: .semibold, size: 20)
    }
    
    static var pretendardSemibold16: Font {
        return .pretendard(type: .semibold, size: 16)
    }
    
    static var pretendardSemibold14: Font {
        return .pretendard(type: .semibold, size: 14)
    }
    
    static var pretendardMedium16: Font {
        return .pretendard(type: .medium, size: 16)
    }
    
    static var pretendardMedium15: Font {
        return .pretendard(type: .medium, size: 15)
    }
    
    static var pretendardMedium12: Font {
        return .pretendard(type: .medium, size: 12)
    }
    
    static var pretendardRegular14: Font {
        return .pretendard(type: .regular, size: 14)
    }
    
    // MARK: - Galmuri
    static func galmuri(size: CGFloat) -> Font {
        return .custom("Galmuri7-Regular", size: size)
    }
    
    static var galmuri20: Font {
        return .galmuri(size: 20)
    }
    
    static var galmuri18: Font {
        return .galmuri(size: 18)
    }
    
    static var galmuri15: Font {
        return .galmuri(size: 15)
    }
}
