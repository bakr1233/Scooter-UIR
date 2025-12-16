import SwiftUI

struct LoginScreen: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    Color.black
                        .ignoresSafeArea()
                    
                    ScrollView {
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
                        .padding(.top, 20)
                        
                        // Date and Time Display
                        Text(getCurrentDateTime())
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                            .padding(.top, 20)
                        
                        // Connection Form Card
                        VStack(alignment: .leading, spacing: 20) {
                            // Separator line
                            Rectangle()
                                .fill(Color.white.opacity(0.3))
                                .frame(height: 1)
                                .padding(.top, 10)
                            
                            // CONNEXION Title
                            Text("CONNEXION")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.top, 10)
                            
                            // Name Input Field
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Nom/Prénom*")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.white)
                                
                                TextField("Nom,Prénom", text: $name)
                                    .textFieldStyle(LoginTextFieldStyle())
                            }
                            
                            // Email Input Field
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Adress email UIR*")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.white)
                                
                                TextField("Adress email uir", text: $email)
                                    .textFieldStyle(LoginTextFieldStyle())
                                    .keyboardType(.emailAddress)
                                    .autocapitalization(.none)
                            }
                            
                            // Phone Input Field
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Téléphone *")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.white)
                                
                                TextField("Téléphone", text: $phone)
                                    .textFieldStyle(LoginTextFieldStyle())
                                    .keyboardType(.phonePad)
                            }
                            
                            // Social Login Section
                            HStack(spacing: 12) {
                                Text("login with")
                                    .font(.system(size: 14))
                                    .foregroundColor(.white)
                                
                                // Microsoft Icon
                                Button(action: {
                                    // Handle Microsoft login
                                }) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color.white)
                                            .frame(width: 40, height: 40)
                                        
                                        // Microsoft logo (4 squares)
                                        VStack(spacing: 2) {
                                            HStack(spacing: 2) {
                                                Rectangle()
                                                    .fill(Color.blue)
                                                    .frame(width: 8, height: 8)
                                                Rectangle()
                                                    .fill(Color.green)
                                                    .frame(width: 8, height: 8)
                                            }
                                            HStack(spacing: 2) {
                                                Rectangle()
                                                    .fill(Color.orange)
                                                    .frame(width: 8, height: 8)
                                                Rectangle()
                                                    .fill(Color.red)
                                                    .frame(width: 8, height: 8)
                                            }
                                        }
                                    }
                                }
                                
                                // Google Icon
                                Button(action: {
                                    // Handle Google login
                                }) {
                                    ZStack {
                                        Circle()
                                            .fill(Color.white)
                                            .frame(width: 40, height: 40)
                                        
                                        Text("G")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                            .padding(.top, 10)
                        }
                        .padding(20)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(white: 0.15))
                        )
                        .padding(.horizontal, 20)
                        .padding(.top, 30)
                        
                        Spacer(minLength: 40)
                        
                        // NEXT Button
                        NavigationLink(destination: MapScreen()) {
                            HStack(spacing: 0) {
                                Text("NEXT")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 18)
                                    .background(Color(white: 0.2))
                                
                                ZStack {
                                    LinearGradient(
                                        colors: [Color.red, Color.blue],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                    
                                    Image(systemName: "arrow.right")
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundColor(.white)
                                }
                                .frame(width: 60)
                                .padding(.vertical, 18)
                            }
                            .cornerRadius(30)
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 40)
                        }
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    func getCurrentDateTime() -> String {
        let date = Date()
        let calendar = Calendar.current
        
        // Time format
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let timeString = timeFormatter.string(from: date)
        
        // Day of week
        let weekdayFormatter = DateFormatter()
        weekdayFormatter.dateFormat = "EEEE"
        weekdayFormatter.locale = Locale(identifier: "en_US")
        let weekday = weekdayFormatter.string(from: date).lowercased()
        
        // Day number with ordinal
        let day = calendar.component(.day, from: date)
        let ordinal: String
        switch day {
        case 1, 21, 31: ordinal = "st"
        case 2, 22: ordinal = "nd"
        case 3, 23: ordinal = "rd"
        default: ordinal = "th"
        }
        
        // Month name
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MMMM"
        monthFormatter.locale = Locale(identifier: "en_US")
        let month = monthFormatter.string(from: date)
        
        return "\(timeString) | \(weekday), \(day)\(ordinal) \(month)"
    }
}

// Custom TextField Style
struct LoginTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(15)
            .background(Color(white: 0.2))
            .cornerRadius(10)
            .foregroundColor(.white)
            .font(.system(size: 15))
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}

