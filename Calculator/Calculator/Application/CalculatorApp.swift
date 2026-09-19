import SwiftUI

@main
struct CalculatorApp: App {
    @StateObject var viewModel = ViewModelCalculator()
    
    var body: some Scene {
        WindowGroup {
            Calculator()
                .environmentObject(viewModel)
        }
    }
}
