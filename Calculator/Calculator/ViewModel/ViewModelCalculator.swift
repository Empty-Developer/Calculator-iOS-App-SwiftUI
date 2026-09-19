import Combine
import SwiftUI

class ViewModelCalculator: ObservableObject {
    
    // MARK: Property
    // @Published — allows setting and getting a value
    // @Published — indicates that this property can only be used within the
    // structure where it was defined @Published var value: String = "0"
    @Published var value: String = "0"
    @Published var number: Double = 0.0
    @Published var currentOperation: ModelOperation = .none
    @Published var expression: String = ""
    
    let buttonSymbolArray: [[ModelSymbols]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiple],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equal]
    ]
    
    
    // MARK: Tap Button Method
    func didTap(item: ModelSymbols) {
        switch item {
        case .plus, .minus, .multiple, .divide:
            handleOperation(item)
        case .equal:
            if let currentValue = Double(value) {
                expression += " \(value) ="
                let result = performOperation(currentValue)
                value = formatResult(result)
                currentOperation = .none
            }
        case .decimal:
            if !value.contains(".") {
                value += "."
            }
        case .percent:
            if let currentValue = Double(value) {
                value = String(currentValue / 100)
            }
        case .negative:
            if let currentValue = Double(value) {
                value = String(-currentValue)
            }
        case .clear:
            value = "0"
            number = 0.0
            currentOperation = .none
            expression = ""
        default:
            if expression.contains("=") {
                expression = ""
            }
            
            if value == "0" {
                value = item.rawValue
            } else {
                value += item.rawValue
            }
        }
    }
    
    // MARK: Helper Print Method
    private func handleOperation(_ item: ModelSymbols) {
        if expression.contains("=") {
            expression = value + " " + item.rawValue
        } else if currentOperation == .none {
            expression = value + " " + item.rawValue
        } else {
            expression += " \(value) " + item.rawValue
        }
        
        switch item {
        case .plus: currentOperation = .addition
        case .minus: currentOperation = .subtract
        case .multiple: currentOperation = .multiply
        case .divide: currentOperation = .divide
        default: break
        }
        number = Double(value) ?? 0
        value = "0"
        
    }
    
    // MARK: Helper Calculate Method
    private func performOperation(_ currentValue: Double) -> Double {
        switch currentOperation {
        case .addition:
            return number + currentValue
        case .divide:
            return number / currentValue
        case .multiply:
            return number * currentValue
        case .subtract:
            return number - currentValue
        default:
            return currentValue
        }
    }
    
    private func formatResult(_ result: Double) -> String {
        if result.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", result)
        } else {
            return String(result)
        }
    }
    
    // MARK: Size of buttons Methods
    //CGFloat represents a coordinate system measurement, whereas points correspond to pixels.
    // A "point" on the latest displays is 3 by 3 pixels—that is, 9 pixels.
    func buttonWidth (item: ModelSymbols) -> CGFloat {
        // "Spacing" refers to the gaps between the buttons on the screen—specifically, five gaps.
        let spacing: CGFloat = 12
        
        // totalSpacing is the total number of distances, we have 5 of them
        let totalSpacing: CGFloat = 5 * spacing
        
        // number of rows
        let totalColums: CGFloat = 4
        
        // total screen width
        let screenWidth = UIScreen.main.bounds.width
        
        // Now we need to create `totalSpacing`, taking the '0' button into account.
        let zeroTotalSpacing: CGFloat = 4 * spacing
        
        
        // making the button longer.
        if item == .zero {
            return (screenWidth - zeroTotalSpacing) / totalColums * 2
        }
        
        return (screenWidth - totalSpacing) / totalColums
    }
    
    func buttonHeight() -> CGFloat {
        let spacing: CGFloat = 12
        let totalSpacing: CGFloat = 5 * spacing
        let totalColums: CGFloat = 4

        let screenWidth = UIScreen.main.bounds.width
        
        return (screenWidth - totalSpacing) / totalColums
    }
    
}
