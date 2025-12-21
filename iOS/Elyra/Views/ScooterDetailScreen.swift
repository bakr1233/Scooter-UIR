import SwiftUI

struct ScooterDetailScreen: View {
    @Environment(\.dismiss) var dismiss
    @State private var showQRScanner = false
    let scooterName: String
    let batteryLevel: Int
    let maxSpeed: Int
    let pricePerMin: String
    let unlockFee: String
    
    init(scooterName: String = "Segway Ninebot Max G30", batteryLevel: Int = 65, maxSpeed: Int = 20, pricePerMin: String = "1MAD", unlockFee: String = "2MAD") {
        self.scooterName = scooterName
        self.batteryLevel = batteryLevel
        self.maxSpeed = maxSpeed
        self.pricePerMin = pricePerMin
        self.unlockFee = unlockFee
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
                        
                        // Scooter Image Section
                        ZStack {
                            // Background glow effect
                            Circle()
                                .fill(
                                    RadialGradient(
                                        colors: [Color.red.opacity(0.3), Color.clear],
                                        center: .center,
                                        startRadius: 50,
                                        endRadius: 200
                                    )
                                )
                                .frame(width: 400, height: 400)
                                .offset(x: 100, y: 100)
                            
                            // Scooter Visualization
                            ScooterDetailView()
                                .frame(height: geometry.size.height * 0.35)
                                .padding(.top, 20)
                        }
                        
                        Spacer()
                        
                        // Information Panel
                        VStack(alignment: .leading, spacing: 20) {
                            // Title
                            Text("\(scooterName).")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.white)
                            
                            // Description
                            Text("The product with a chamming title -TYPE X- is made in Germany and is described as the one that began a new era.")
                                .font(.system(size: 15))
                                .foregroundColor(Color(white: 0.8))
                                .lineSpacing(4)
                            
                            // Metrics Row
                            HStack(spacing: 30) {
                                // Battery
                                HStack(spacing: 8) {
                                    Image(systemName: "battery.100")
                                        .font(.system(size: 20))
                                        .foregroundColor(.red)
                                    Text("\(batteryLevel)%")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(.red)
                                }
                                
                                // Speed
                                HStack(spacing: 8) {
                                    Image(systemName: "speedometer")
                                        .font(.system(size: 20))
                                        .foregroundColor(.white)
                                    Text("\(maxSpeed)km/h")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(.white)
                                }
                            }
                            
                            // Price
                            HStack(spacing: 8) {
                                Image(systemName: "dollarsign.circle.fill")
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                Text("\(pricePerMin)MAD per ")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white)
                                + Text("MIN")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.red)
                            }
                            
                            // Unlock Fee
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Unlock fee")
                                    .font(.system(size: 14))
                                    .foregroundColor(.white)
                                
                                Text("\(unlockFee)MAD")
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(.red)
                            }
                            .padding(.top, 10)
                        }
                        .padding(25)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color(white: 0.15))
                        )
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                        
                        Spacer()
                    }
                    .navigationDestination(isPresented: $showQRScanner) {
                        QRCodeScannerScreen()
                    }
                    
                    // UNLOCK Button - OVERLAY VERSION (Always on top)
                    VStack {
                        Spacer()
                        
                        Button(action: {
                            showQRScanner = true
                        }) {
                            HStack {
                                Text("UNLOCK")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.white)
                                
                                Spacer()
                                
                                Image(systemName: "arrow.right")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 30)
                            .padding(.vertical, 25)
                            .background(Color.red)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.yellow, lineWidth: 5)
                            )
                            .cornerRadius(30)
                            .shadow(color: .red, radius: 20, x: 0, y: 10)
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 30)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    
    
    // Scooter Detail View
    struct ScooterDetailView: View {
        var body: some View {
            ZStack {
                // Main scooter body
                VStack(spacing: 0) {
                    // Handlebars
                    HStack(spacing: 60) {
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color(white: 0.3))
                            .frame(width: 50, height: 4)
                        
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color(white: 0.3))
                            .frame(width: 50, height: 4)
                    }
                    .offset(y: -10)
                    
                    // Stem
                    VStack(spacing: 0) {
                        // Screen/display area
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color(white: 0.1))
                            .frame(width: 50, height: 35)
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color(white: 0.3), lineWidth: 1)
                            )
                        
                        // Stem body
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(white: 0.25))
                            .frame(width: 60, height: 120)
                            .overlay(
                                Text("ninebot")
                                    .font(.system(size: 10, weight: .medium))
                                    .foregroundColor(.white.opacity(0.6))
                                    .rotationEffect(.degrees(-90))
                                    .offset(y: 20)
                            )
                    }
                    
                    // Deck/Footboard
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(white: 0.2))
                        .frame(width: 200, height: 25)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(white: 0.3), lineWidth: 1)
                        )
                    
                    // Wheels
                    HStack(spacing: 140) {
                        // Front wheel
                        ZStack {
                            Circle()
                                .fill(Color(white: 0.15))
                                .frame(width: 70, height: 70)
                            
                            Circle()
                                .stroke(Color.blue, lineWidth: 3)
                                .frame(width: 70, height: 70)
                            
                            Circle()
                                .fill(Color(white: 0.1))
                                .frame(width: 50, height: 50)
                        }
                        
                        // Rear wheel
                        ZStack {
                            Circle()
                                .fill(Color(white: 0.15))
                                .frame(width: 70, height: 70)
                            
                            Circle()
                                .stroke(Color.blue, lineWidth: 3)
                                .frame(width: 70, height: 70)
                            
                            Circle()
                                .fill(Color(white: 0.1))
                                .frame(width: 50, height: 50)
                        }
                    }
                    .offset(y: -10)
                }
            }
        }
    }
    
    struct ScooterDetailScreen_Previews: PreviewProvider {
        static var previews: some View {
            ScooterDetailScreen()
        }
    }
    
}
