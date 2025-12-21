import SwiftUI

struct ProfileScreen: View {
    @State private var showWalletTopUp = false
    
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
                            Text("Profile")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.white)
                            
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        
                        ScrollView {
                            VStack(spacing: 25) {
                                // Profile Header
                                VStack(spacing: 15) {
                                    // Profile Picture
                                    ZStack {
                                        Circle()
                                            .fill(
                                                LinearGradient(
                                                    colors: [.red, .purple, .blue],
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing
                                                )
                                            )
                                            .frame(width: 100, height: 100)
                                        
                                        Text("E")
                                            .font(.system(size: 48, weight: .bold))
                                            .foregroundColor(.white)
                                    }
                                    
                                    Text("User Name")
                                        .font(.system(size: 24, weight: .semibold))
                                        .foregroundColor(.white)
                                    
                                    Text("user@uir.ac.ma")
                                        .font(.system(size: 14))
                                        .foregroundColor(.gray)
                                }
                                .padding(.top, 30)
                                
                                // Wallet Section
                                Button(action: {
                                    showWalletTopUp = true
                                }) {
                                    HStack {
                                        VStack(alignment: .leading, spacing: 8) {
                                            Text("Wallet")
                                                .font(.system(size: 18, weight: .semibold))
                                                .foregroundColor(.white)
                                            
                                            Text("50.00 MAD")
                                                .font(.system(size: 24, weight: .bold))
                                                .foregroundColor(.white)
                                        }
                                        
                                        Spacer()
                                        
                                        Image(systemName: "chevron.right")
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundColor(.white)
                                    }
                                    .padding(20)
                                    .background(
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(Color(white: 0.15))
                                    )
                                }
                                .padding(.horizontal, 20)
                                
                                // Other Profile Options
                                VStack(spacing: 0) {
                                    ProfileOptionRow(icon: "person.fill", title: "Edit Profile")
                                    Divider().background(Color(white: 0.2))
                                    ProfileOptionRow(icon: "clock.fill", title: "Ride History")
                                    Divider().background(Color(white: 0.2))
                                    ProfileOptionRow(icon: "bell.fill", title: "Notifications")
                                    Divider().background(Color(white: 0.2))
                                    ProfileOptionRow(icon: "questionmark.circle.fill", title: "Help & Support")
                                    Divider().background(Color(white: 0.2))
                                    ProfileOptionRow(icon: "gear", title: "Settings")
                                }
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color(white: 0.15))
                                )
                                .padding(.horizontal, 20)
                                
                                Spacer(minLength: 50)
                            }
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $showWalletTopUp) {
                WalletTopUpScreen()
            }
        }
    }
}

// Profile Option Row Component
struct ProfileOptionRow: View {
    let icon: String
    let title: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(.white)
                .frame(width: 30)
            
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.white)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 18)
    }
}

struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen()
    }
}

