import SwiftUI

struct WelcomeScreen: View {
    @State private var showLoginScreen = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    Color.black
                        .ignoresSafeArea()
                    
                    VStack(spacing: 0) {
                        // Status Bar
                        StatusBarView()
                        
                        // Logo Section
                        HStack(spacing: 10) {
                            // Logo Icon with Gradient
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(
                                        LinearGradient(
                                            colors: [.red, .purple, .blue],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(width: 40, height: 40)
                                
                                Text("e")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.white)
                            }
                            
                            // Logo Text with Gradient
                            Text("Elyra")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [Color(red: 0.545, green: 0, blue: 0), .purple],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        
                        // Scooter Visualization
                        ScooterView()
                            .frame(maxWidth: .infinity)
                            .frame(height: geometry.size.height * 0.4)
                        
                        Spacer()
                        
                        // Welcome Section
                        VStack(alignment: .leading, spacing: 15) {
                            HStack(spacing: 4) {
                                Text("Welcome")
                                    .font(.system(size: 36, weight: .bold))
                                    .foregroundColor(.white)
                                
                                Circle()
                                    .fill(Color.red)
                                    .frame(width: 8, height: 8)
                            }
                            
                            (Text("Bienvenue chez ") + Text("Elyra").fontWeight(.semibold).foregroundColor(.white) + Text(" — la solution de mobilité électrique qui facilite les déplacements au sein du campus. Grâce à nos scooters écologiques et silencieux, se déplacer entre les bâtiments devient plus rapide, pratique et respectueux de l'environnement. Avec Elyra, la mobilité universitaire entre dans une nouvelle ère."))
                                .font(.system(size: 15))
                                .foregroundColor(Color(white: 0.8))
                                .lineSpacing(4)
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 30)
                        
                        // Get Started Button
                        NavigationLink(destination: LoginScreen()) {
                            HStack(spacing: 12) {
                                ZStack {
                                    Circle()
                                        .stroke(Color.white, lineWidth: 1.5)
                                        .frame(width: 32, height: 32)
                                    
                                    Text("→")
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundColor(.white)
                                }
                                
                                Text("Get Started...")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.white)
                                
                                Spacer()
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 16)
                            .background(
                                LinearGradient(
                                    colors: [Color(red: 0.1, green: 0.1, blue: 0.18), Color(red: 0.545, green: 0, blue: 0)],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(30)
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 40)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

// Status Bar View
struct StatusBarView: View {
    var body: some View {
        HStack {
            Text("9:41")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.white)
            
            Spacer()
            
            HStack(spacing: 6) {
                // Signal Bars
                HStack(spacing: 2) {
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 3, height: 4)
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 3, height: 6)
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 3, height: 8)
                }
                
                // WiFi Icon
                ZStack {
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(Color.white, lineWidth: 1.5)
                        .frame(width: 15, height: 11)
                }
                
                // Battery Icon
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color.white)
                    .frame(width: 24, height: 12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 2)
                            .stroke(Color.white, lineWidth: 1.5)
                            .frame(width: 24, height: 12)
                    )
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
        .padding(.bottom, 5)
    }
}

// Scooter View
struct ScooterView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Scooter Stem (Red)
                VStack(spacing: 0) {
                    // Screen on stem
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color(white: 0.1))
                        .frame(width: 35, height: 25)
                        .padding(.top, 10)
                    
                    // Stem body
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.red)
                        .frame(width: 50, height: geometry.size.height * 0.6)
                        .overlay(
                            Text("Elyra")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.white)
                                .rotationEffect(.degrees(-90))
                                .offset(y: 30)
                        )
                }
                .offset(x: 0, y: -geometry.size.height * 0.1)
                
                // Handlebars
                HStack(spacing: 20) {
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color(white: 0.2))
                        .frame(width: 50, height: 3)
                    
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color(white: 0.2))
                        .frame(width: 50, height: 3)
                }
                .offset(x: 0, y: -geometry.size.height * 0.15)
                
                // Deck
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(white: 0.1))
                    .frame(width: 160, height: 20)
                    .overlay(
                        LinearGradient(
                            colors: [
                                Color.blue.opacity(0.3),
                                Color.red.opacity(0.3)
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .frame(height: 20)
                        .cornerRadius(10)
                    )
                    .offset(x: 0, y: geometry.size.height * 0.2)
                
                // Wheels
                HStack(spacing: 20) {
                    Circle()
                        .fill(Color(white: 0.2))
                        .frame(width: 50, height: 50)
                        .overlay(
                            Circle()
                                .stroke(Color(white: 0.1), lineWidth: 3)
                        )
                    
                    Circle()
                        .fill(Color(white: 0.2))
                        .frame(width: 50, height: 50)
                        .overlay(
                            Circle()
                                .stroke(Color(white: 0.1), lineWidth: 3)
                        )
                }
                .offset(x: 0, y: geometry.size.height * 0.3)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    WelcomeScreen()
}

