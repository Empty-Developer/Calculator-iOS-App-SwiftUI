import SwiftUI

struct Calculator: View {
    
    @EnvironmentObject var viewModel: ViewModelCalculator
    
    var body: some View {
        ZStack {
            // MARK: Bacground
            Color.appbackground
                .ignoresSafeArea()
            
            VStack {
                
                // MARK: Display
                ZStack {
                    VStack {
                        HStack {
                            Spacer()
                            Text(viewModel.value)
                                .foregroundStyle(.appCount)
                                .orbitronFont(fontType: .regular, size: 54)
                                .padding(.trailing, 20)
                                .padding(.bottom, 10)
                                .padding(.top, 60)
                        }
                        HStack {
                            Spacer()
                            Text(viewModel.expression.isEmpty ? " " : viewModel.expression)
                                .foregroundStyle(.appCount)
                                .orbitronFont(fontType: .regular, size: 20)
                                .padding(.trailing, 20)
                        }
                        
                    }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    .appDisplay,
                    in: RoundedRectangle(cornerRadius: 20, style: .continuous)
                )
                .padding(24)
                
                // MARK: Button Symbol
                
                // \.self - assign a unique identifier to each element of the array.
                ForEach(viewModel.buttonSymbolArray, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { items in
                            Button{
                                viewModel.didTap(item: items)
                            } label: {
                                Text(items.rawValue)
                                    .foregroundStyle(.apptext)
                                .orbitronFont(fontType: .regular, size: 36)
                                    .frame(width: viewModel.buttonWidth(item: items), height: viewModel.buttonHeight())
                                    .background(items.symbolsColor)
                                    .cornerRadius(40)
                                
                            }
                        }
                    }
                }
                
            }
        }
        
    }
    
}

#Preview {
    Calculator()
        .environmentObject(ViewModelCalculator())
}

