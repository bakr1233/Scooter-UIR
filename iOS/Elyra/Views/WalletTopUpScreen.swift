import SwiftUI

struct WalletTopUpScreen: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedAmount: Double = 50.0
    @State private var selectedPaymentMethod: PaymentMethod? = nil
    
    enum PaymentMethod {
        case voucher
        case creditCard
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    Color.black
                        .ignoresSafeArea()
                    
                    VStack(spacing: 0) {
                        // Status Bar
                        StatusBarView()
                        
                        // Navigation Bar
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
                            
                            Text("Top up Wallet")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            // Balance the back button
                            Circle()
                                .fill(Color.clear)
                                .frame(width: 40, height: 40)
                                .padding(.trailing, 20)
                        }
                        .padding(.top, 10)
                        
                        ScrollView {
                            VStack(spacing: 30) {
                                // Current Amount Display Card
                                VStack(spacing: 12) {
                                    Text("\(selectedAmount, specifier: "%.2f") MAD")
                                        .font(.system(size: 48, weight: .bold))
                                        .foregroundColor(.white)
                                    
                                    HStack(spacing: 6) {
                                        Image(systemName: "bolt.fill")
                                            .font(.system(size: 12))
                                            .foregroundColor(.yellow)
                                        
                                        Text("ELYRA JUICE")
                                            .font(.system(size: 12, weight: .medium))
                                            .foregroundColor(.white)
                                    }
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(
                                        Capsule()
                                            .fill(Color(white: 0.2))
                                    )
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 40)
                                .padding(.horizontal, 30)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color(white: 0.15))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color.red.opacity(0.5), lineWidth: 2)
                                        )
                                )
                                .padding(.horizontal, 20)
                                .padding(.top, 30)
                                
                                // Pre-set Amount Buttons (2x2 Grid)
                                VStack(spacing: 15) {
                                    HStack(spacing: 15) {
                                        AmountButton(
                                            amount: 20.0,
                                            isSelected: selectedAmount == 20.0,
                                            isBestValue: false
                                        ) {
                                            selectedAmount = 20.0
                                        }
                                        
                                        AmountButton(
                                            amount: 50.0,
                                            isSelected: selectedAmount == 50.0,
                                            isBestValue: true
                                        ) {
                                            selectedAmount = 50.0
                                        }
                                    }
                                    
                                    HStack(spacing: 15) {
                                        AmountButton(
                                            amount: 100.0,
                                            isSelected: selectedAmount == 100.0,
                                            isBestValue: false
                                        ) {
                                            selectedAmount = 100.0
                                        }
                                        
                                        AmountButton(
                                            amount: 200.0,
                                            isSelected: selectedAmount == 200.0,
                                            isBestValue: false
                                        ) {
                                            selectedAmount = 200.0
                                        }
                                    }
                                }
                                .padding(.horizontal, 20)
                                
                                // Payment Method Options
                                VStack(spacing: 0) {
                                    // VOUCHER Option
                                    Button(action: {
                                        selectedPaymentMethod = .voucher
                                    }) {
                                        HStack {
                                            Image(systemName: "scissors")
                                                .font(.system(size: 20))
                                                .foregroundColor(.white)
                                                .frame(width: 30)
                                            
                                            Text("VOUCHER")
                                                .font(.system(size: 16, weight: .medium))
                                                .foregroundColor(.white)
                                            
                                            Spacer()
                                            
                                            Image(systemName: "chevron.right")
                                                .font(.system(size: 14, weight: .semibold))
                                                .foregroundColor(.white)
                                        }
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 18)
                                        .background(
                                            selectedPaymentMethod == .voucher ? Color.red.opacity(0.2) : Color.clear
                                        )
                                    }
                                    
                                    // Divider
                                    Rectangle()
                                        .fill(Color(white: 0.2))
                                        .frame(height: 1)
                                        .padding(.horizontal, 20)
                                    
                                    // CREDIT CARD Option
                                    Button(action: {
                                        selectedPaymentMethod = .creditCard
                                    }) {
                                        HStack {
                                            Image(systemName: "creditcard")
                                                .font(.system(size: 20))
                                                .foregroundColor(.white)
                                                .frame(width: 30)
                                            
                                            Text("CREDIT CARD")
                                                .font(.system(size: 16, weight: .medium))
                                                .foregroundColor(.white)
                                            
                                            Spacer()
                                            
                                            Image(systemName: "chevron.right")
                                                .font(.system(size: 14, weight: .semibold))
                                                .foregroundColor(.white)
                                        }
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 18)
                                        .background(
                                            selectedPaymentMethod == .creditCard ? Color.red.opacity(0.2) : Color.clear
                                        )
                                    }
                                }
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color(white: 0.15))
                                )
                                .padding(.horizontal, 20)
                                .padding(.top, 20)
                                
                                Spacer(minLength: 100)
                            }
                        }
                        
                        // ADD FUNDS Button
                        Button(action: {
                            // Handle add funds action
                        }) {
                            HStack {
                                Text("ADD FUNDS")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.white)
                                
                                Spacer()
                                
                                Image(systemName: "arrow.right")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal, 30)
                            .padding(.vertical, 18)
                            .background(
                                LinearGradient(
                                    colors: [Color.blue, Color.red],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(30)
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 30)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

// Amount Button Component
struct AmountButton: View {
    let amount: Double
    let isSelected: Bool
    let isBestValue: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack(alignment: .topTrailing) {
                VStack(spacing: 8) {
                    Text("\(Int(amount))")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("MAD")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color(white: 0.15))
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(isSelected ? Color.red : Color.clear, lineWidth: 2)
                        )
                )
                
                if isBestValue {
                    Text("Best value")
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 3)
                        .background(
                            Capsule()
                                .fill(Color.red)
                        )
                        .offset(x: -8, y: 8)
                }
            }
        }
    }
}

struct WalletTopUpScreen_Previews: PreviewProvider {
    static var previews: some View {
        WalletTopUpScreen()
    }
}

