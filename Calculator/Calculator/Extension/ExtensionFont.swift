import Foundation
import UIKit
import SwiftUI

struct FontModifier: ViewModifier {
    var fontType: OrbitronType
    var size: CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(.custom(fontType.rawValue, size: size))
    }
}

extension Text{
    func orbitronFont(fontType: OrbitronType = .medium, size: CGFloat = 16) -> some View {
        self.modifier(FontModifier(fontType: fontType, size: size))
    }
}

extension UIFont {
    static func getCustomFont(fontType: OrbitronType = .regular, size: CGFloat = 16) -> UIFont {
        .init(name: fontType.rawValue, size: size) ?? .systemFont(ofSize: size)
    }
}
