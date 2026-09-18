import Foundation
import SwiftUI
import UIKit


// Family: Orbitron Font Names: ["Orbitron-Regular", "Orbitron-Medium", "Orbitron-SemiBold", "Orbitron-Bold", "Orbitron-ExtraBold", "Orbitron-Black"]

enum OrbitronType: String {
    case regular = "Orbitron-Regular"
    case medium = "Orbitron-Medium"
    case semiBold = "Orbitron-SemiBold"
    case bold = "Orbitron-Bold"
    case extraBold = "Orbitron-ExtraBold"
    case black = "Orbitron-Black"
}


extension UIFont {
    static func getCustomFont(fontType: OrbitronType = .regular, size: CGFloat = 16) -> UIFont {
        .init(name: fontType.rawValue, size: size) ?? .systemFont(ofSize: size)
    }
}
