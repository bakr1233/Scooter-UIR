import SwiftUI

struct ManualCodeEntryScreen: View {
    @Environment(\.dismiss) var dismiss
    @State private var code: String = ""
    @State private var showKeypad = true
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Status Bar
                    StatusBarView()
                    
                    // Navigation Bar with Back Button
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 40, height: 40)
                                
                                Image(systemName: "arrow.left")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(.leading, 20)
                        .padding(.top, 10)
                        
                        Spacer()
                    }
                    
                    // Header Text
                    Text("enter the scooter code")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    
                    Spacer()
                    
                    // Code Input Field
                    VStack(spacing: 30) {
                        // Input Display
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color(white: 0.1))
                                .frame(width: 280, height: 80)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(code.isEmpty ? Color.gray : Color.red, lineWidth: 2)
                                )
                            
                            HStack(spacing: 8) {
                                ForEach(0..<4, id: \.self) { index in
                                    Text(index < code.count ? String(code[code.index(code.startIndex, offsetBy: index)]) : "0")
                                        .font(.system(size: 48, weight: .bold))
                                        .foregroundColor(.white)
                                        .monospacedDigit()
                                }
                            }
                        }
                        .padding(.top, 40)
                        
                        // Numeric Keypad
                        if showKeypad {
                            VStack(spacing: 20) {
                                // Row 1: 1, 2, 3
                                HStack(spacing: 20) {
                                    KeypadButton(number: "1", action: { appendDigit("1") })
                                    KeypadButton(number: "2", action: { appendDigit("2") })
                                    KeypadButton(number: "3", action: { appendDigit("3") })
                                }
                                
                                // Row 2: 4, 5, 6
                                HStack(spacing: 20) {
                                    KeypadButton(number: "4", action: { appendDigit("4") })
                                    KeypadButton(number: "5", action: { appendDigit("5") })
                                    KeypadButton(number: "6", action: { appendDigit("6") })
                                }
                                
                                // Row 3: 7, 8, 9
                                HStack(spacing: 20) {
                                    KeypadButton(number: "7", action: { appendDigit("7") })
                                    KeypadButton(number: "8", action: { appendDigit("8") })
                                    KeypadButton(number: "9", action: { appendDigit("9") })
                                }
                                
                                // Row 4: Delete, 0
                                HStack(spacing: 20) {
                                    // Delete Button
                                    Button(action: {
                                        if !code.isEmpty {
                                            code.removeLast()
                                        }
                                    }) {
                                        ZStack {
                                            Circle()
                                                .fill(
                                                    LinearGradient(
                                                        colors: [Color(white: 0.2), Color(white: 0.15)],
                                                        startPoint: .topLeading,
                                                        endPoint: .bottomTrailing
                                                    )
                                                )
                                                .frame(width: 70, height: 70)
                                                .overlay(
                                                    Circle()
                                                        .stroke(Color(white: 0.3), lineWidth: 1)
                                                )
                                            
                                            Image(systemName: "delete.left")
                                                .font(.system(size: 24, weight: .semibold))
                                                .foregroundColor(.white)
                                        }
                                    }
                                    
                                    KeypadButton(number: "0", action: { appendDigit("0") })
                                    
                                    // Empty space to balance
                                    Circle()
                                        .fill(Color.clear)
                                        .frame(width: 70, height: 70)
                                }
                            }
                            .padding(.horizontal, 40)
                            .padding(.top, 20)
                        }
                        
                        Spacer()
                        
                        // Dismiss Keypad Button
                        if showKeypad {
                            Button(action: {
                                showKeypad = false
                            }) {
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(.bottom, 30)
                            }
                        }
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
    
    private func appendDigit(_ digit: String) {
        if code.count < 4 {
            code += digit
        }
    }
}

// Keypad Button Component
struct KeypadButton: View {
    let number: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color(white: 0.2), Color(white: 0.15)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 70, height: 70)
                    .overlay(
                        Circle()
                            .stroke(Color(white: 0.3), lineWidth: 1)
                    )
                
                Text(number)
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundColor(.white)
            }
        }
    }
}

struct ManualCodeEntryScreen_Previews: PreviewProvider {
    static var previews: some View {
        ManualCodeEntryScreen()
    }
}

