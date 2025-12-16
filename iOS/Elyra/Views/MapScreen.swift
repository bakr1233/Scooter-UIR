import SwiftUI
import MapKit

struct MapScreen: View {
    @State private var selectedScooter: ScooterType? = nil
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 33.9981, longitude: -6.8480), // Rabat, Morocco approximate
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
    )
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    // Map View
                    Map(position: $cameraPosition) {
                        ForEach(mapAnnotations) { annotation in
                            Annotation("", coordinate: annotation.coordinate) {
                                annotation.view
                            }
                        }
                    }
                    .mapStyle(.standard)
                    .ignoresSafeArea()
                    
                    // Status Bar Overlay
                    VStack {
                        HStack {
                            Text("9:41")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            HStack(spacing: 6) {
                                // Signal Bars
                                HStack(spacing: 2) {
                                    Rectangle()
                                        .fill(Color.black)
                                        .frame(width: 3, height: 4)
                                    Rectangle()
                                        .fill(Color.black)
                                        .frame(width: 3, height: 6)
                                    Rectangle()
                                        .fill(Color.black)
                                        .frame(width: 3, height: 8)
                                }
                                
                                // WiFi Icon
                                ZStack {
                                    RoundedRectangle(cornerRadius: 2)
                                        .stroke(Color.black, lineWidth: 1.5)
                                        .frame(width: 15, height: 11)
                                }
                                
                                // Battery Icon
                                RoundedRectangle(cornerRadius: 2)
                                    .fill(Color.black)
                                    .frame(width: 24, height: 12)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 2)
                                            .stroke(Color.black, lineWidth: 1.5)
                                            .frame(width: 24, height: 12)
                                    )
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                        .padding(.bottom, 5)
                        
                        Spacer()
                    }
                    
                    // Weather Widget
                    VStack {
                        HStack {
                            Spacer()
                            WeatherWidget()
                                .padding(.trailing, 20)
                                .padding(.top, 10)
                        }
                        Spacer()
                    }
                    
                    // Bottom Panel
                    VStack {
                        Spacer()
                        ScooterSelectionPanel(selectedScooter: $selectedScooter)
                            .frame(height: geometry.size.height * 0.35)
                    }
                }
                .navigationBarHidden(true)
            }
        }
        
        var mapAnnotations: [MapAnnotationItem] {
            [
                // Points of Interest
                MapAnnotationItem(
                    coordinate: CLLocationCoordinate2D(latitude: 33.9981, longitude: -6.8480),
                    view: AnyView(POIAnnotation(type: .hospital, title: "HÔPITAL UNIVERSITAIRE UIR"))
                ),
                MapAnnotationItem(
                    coordinate: CLLocationCoordinate2D(latitude: 33.9985, longitude: -6.8485),
                    view: AnyView(POIAnnotation(type: .university, title: "UIR checkpoint access"))
                ),
                MapAnnotationItem(
                    coordinate: CLLocationCoordinate2D(latitude: 33.9975, longitude: -6.8475),
                    view: AnyView(POIAnnotation(type: .university, title: "Rabat Business School"))
                ),
                MapAnnotationItem(
                    coordinate: CLLocationCoordinate2D(latitude: 33.9983, longitude: -6.8483),
                    view: AnyView(POIAnnotation(type: .restaurant, title: "UIRESTO"))
                ),
                // Scooters
                MapAnnotationItem(
                    coordinate: CLLocationCoordinate2D(latitude: 33.9982, longitude: -6.8482),
                    view: AnyView(ScooterMapIcon(color: .green))
                ),
                MapAnnotationItem(
                    coordinate: CLLocationCoordinate2D(latitude: 33.9984, longitude: -6.8484),
                    view: AnyView(ScooterMapIcon(color: .green))
                ),
                MapAnnotationItem(
                    coordinate: CLLocationCoordinate2D(latitude: 33.9980, longitude: -6.8480),
                    view: AnyView(ScooterMapIcon(color: .yellow))
                ),
                MapAnnotationItem(
                    coordinate: CLLocationCoordinate2D(latitude: 33.9986, longitude: -6.8486),
                    view: AnyView(ScooterMapIcon(color: .red))
                )
            ]
        }
    }
    
    // Weather Widget
    struct WeatherWidget: View {
        var body: some View {
            HStack(spacing: 8) {
                Image(systemName: "cloud.rain.fill")
                    .foregroundColor(.blue)
                Text("15%")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white.opacity(0.9))
            )
        }
    }
    
    // Scooter Selection Panel
    struct ScooterSelectionPanel: View {
        @Binding var selectedScooter: ScooterType?
        
        var body: some View {
            VStack(spacing: 0) {
                // Title
                HStack {
                    Text("Choose Scooter")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 15)
                
                // Scooter Options
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ScooterCard(
                            name: "Type X",
                            price: "1MAD",
                            isSelected: selectedScooter == .typeX,
                            color: .black
                        )
                        .onTapGesture {
                            selectedScooter = .typeX
                        }
                        
                        ScooterCard(
                            name: "Blaupunkt",
                            price: "1MAD",
                            isSelected: selectedScooter == .blaupunkt,
                            color: .blue
                        )
                        .onTapGesture {
                            selectedScooter = .blaupunkt
                        }
                        
                        ScooterCard(
                            name: "Cbra",
                            price: "1MAD",
                            isSelected: selectedScooter == .cbra,
                            color: .black
                        )
                        .onTapGesture {
                            selectedScooter = .cbra
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.bottom, 15)
                
                // Action Bar
                HStack {
                    Text("Nearest: 183m")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                NavigationLink(destination: ScooterDetailScreen()) {
                        HStack(spacing: 8) {
                            Text("UNLOCK")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                            
                            Image(systemName: "arrow.right")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 14)
                        .background(
                            LinearGradient(
                                colors: [Color.red, Color.blue],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(25)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color(white: 0.15))
            )
            .padding(.horizontal, 0)
        }
    }
    
    // Scooter Card
    struct ScooterCard: View {
        let name: String
        let price: String
        let isSelected: Bool
        let color: Color
        
        var body: some View {
            VStack(spacing: 10) {
                // Scooter Icon
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(color.opacity(0.3))
                        .frame(width: 100, height: 80)
                    
                    // Simple scooter representation
                    VStack(spacing: 4) {
                        // Handlebars
                        HStack(spacing: 8) {
                            Circle()
                                .fill(color)
                                .frame(width: 4, height: 4)
                            Circle()
                                .fill(color)
                                .frame(width: 4, height: 4)
                        }
                        
                        // Stem
                        RoundedRectangle(cornerRadius: 2)
                            .fill(color)
                            .frame(width: 6, height: 20)
                        
                        // Deck
                        RoundedRectangle(cornerRadius: 4)
                            .fill(color)
                            .frame(width: 40, height: 8)
                        
                        // Wheels
                        HStack(spacing: 12) {
                            Circle()
                                .fill(color)
                                .frame(width: 12, height: 12)
                            Circle()
                                .fill(color)
                                .frame(width: 12, height: 12)
                        }
                    }
                }
                
                // Name and Price
                VStack(spacing: 4) {
                    Text(name)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                    
                    Text("Per min: \(price)")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(white: 0.2))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(isSelected ? Color.red : Color.clear, lineWidth: 2)
                    )
            )
            .frame(width: 120)
        }
    }
    
    // POI Annotation
    struct POIAnnotation: View {
        enum POIType {
            case hospital
            case university
            case restaurant
        }
        
        let type: POIType
        let title: String
        
        var body: some View {
            VStack(spacing: 4) {
                ZStack {
                    Circle()
                        .fill(backgroundColor)
                        .frame(width: 30, height: 30)
                    
                    if type == .hospital {
                        Text("H")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                    } else {
                        Image(systemName: iconName)
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                
                Text(title)
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(.black)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 3)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color.white.opacity(0.9))
                    )
            }
        }
        
        var backgroundColor: Color {
            switch type {
            case .hospital: return .red
            case .university: return .blue
            case .restaurant: return .orange
            }
        }
        
        var iconName: String {
            switch type {
            case .hospital: return "cross.case.fill"
            case .university: return "graduationcap.fill"
            case .restaurant: return "fork.knife"
            }
        }
    }
    
    // Scooter Map Icon
    struct ScooterMapIcon: View {
        let color: Color
        
        var body: some View {
            ZStack {
                Circle()
                    .fill(color)
                    .frame(width: 20, height: 20)
                
                Image(systemName: "scooter")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.white)
            }
        }
    }
    
    // Map Annotation Item
    struct MapAnnotationItem: Identifiable {
        let id = UUID()
        let coordinate: CLLocationCoordinate2D
        let view: AnyView
    }
    
    // Scooter Type Enum
    enum ScooterType {
        case typeX
        case blaupunkt
        case cbra
    }
    
    struct MapScreen_Previews: PreviewProvider {
        static var previews: some View {
            MapScreen()
        }
    }
    
}
