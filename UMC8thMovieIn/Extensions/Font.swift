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
    
    // MARK: - Inter
    enum Inter {
        case bold
        case semibold
        case medium
        case regular
        
        var value: String {
            switch self {
            case .bold:
                return "Inter-Regular_Bold"
            case .semibold:
                return "Inter-Regular_SemiBold"
            case .medium:
                return "Inter-Regular_Medium"
            case .regular:
                return "Inter-Regular"
            }
        }
    }
    
    static func inter(type: Inter, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
    
    static var interBold22: Font {
        return .inter(type: .bold, size: 22)
    }
    
    static var interSemibold20: Font {
        return .inter(type: .semibold, size: 20)
    }
    
    static var interSemibold16: Font {
        return .inter(type: .semibold, size: 16)
    }
    
    static var interSemibold14: Font {
        return .inter(type: .semibold, size: 14)
    }
    
    static var interMedium16: Font {
        return .inter(type: .medium, size: 16)
    }
    
    static var interMedium15: Font {
        return .inter(type: .medium, size: 15)
    }
    
    static var interMedium12: Font {
        return .inter(type: .medium, size: 12)
    }
    
    static var interRegular14: Font {
        return .inter(type: .regular, size: 14)
    }
    
    // MARK: - Galmuri
    static func galmuri(size: CGFloat) -> Font {
        return .custom("Galmuri7-Regular", size: size)
    }
    
    static var galmuri20: Font {
        return .galmuri(size: 20)
    }
    
    static var galmuri15: Font {
        return .galmuri(size: 15)
    }
}
