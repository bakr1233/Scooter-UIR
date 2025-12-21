import SwiftUI
import AVFoundation

struct QRScannerScreen: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var scanner = QRScannerViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Status Bar
                    StatusBarView()
                    
                    // Header with Back Button
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
                    
                    // Title
                    Text("scan the QR code")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    
                    // Scooter Visualization
                    ScooterQRView()
                        .frame(height: geometry.size.height * 0.2)
                        .padding(.top, 30)
                    
                    Spacer()
                    
                    // QR Code Scanner Area
                    ZStack {
                        // Camera Preview
                        if scanner.isAuthorized {
                            CameraPreview(scanner: scanner)
                                .frame(width: 250, height: 250)
                                .cornerRadius(20)
                        } else {
                            // Placeholder QR Code
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                                .frame(width: 250, height: 250)
                                .overlay(
                                    // Simple QR code pattern representation
                                    VStack(spacing: 2) {
                                        ForEach(0..<25) { row in
                                            HStack(spacing: 2) {
                                                ForEach(0..<25) { col in
                                                    Rectangle()
                                                        .fill((row + col) % 3 == 0 ? Color.black : Color.white)
                                                        .frame(width: 8, height: 8)
                                                }
                                            }
                                        }
                                    }
                                )
                        }
                        
                        // Corner Brackets
                        QRCodeFrame()
                    }
                    .padding(.bottom, 40)
                    
                    Spacer()
                    
                    // Bottom Action Bar
                    HStack {
                        Spacer()
                        
                        // Manual Code Entry Button
                        Button(action: {
                            // Handle manual code entry
                        }) {
                            VStack(spacing: 8) {
                                Image(systemName: "lock.fill")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                                
                                Text("***")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.white)
                            }
                        }
                        
                        Spacer()
                        
                        // Flashlight Toggle Button
                        Button(action: {
                            scanner.toggleTorch()
                        }) {
                            Image(systemName: scanner.isTorchOn ? "flashlight.on.fill" : "flashlight.off.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                    }
                    .padding(.bottom, 40)
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            scanner.requestCameraPermission()
        }
    }
}

// QR Scanner View Model
class QRScannerViewModel: NSObject, ObservableObject, AVCaptureMetadataOutputObjectsDelegate {
    @Published var isAuthorized = false
    @Published var isTorchOn = false
    @Published var scannedCode: String?
    
    var captureSession: AVCaptureSession?
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    private var torchDevice: AVCaptureDevice?
    
    override init() {
        super.init()
        setupCamera()
    }
    
    func requestCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
            DispatchQueue.main.async {
                self?.isAuthorized = granted
                if granted {
                    self?.startSession()
                }
            }
        }
    }
    
    private func setupCamera() {
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {
            return
        }
        
        torchDevice = captureDevice
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            let captureSession = AVCaptureSession()
            captureSession.addInput(input)
            
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [.qr]
            
            self.captureSession = captureSession
        } catch {
            print("Error setting up camera: \(error)")
        }
    }
    
    func startSession() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.captureSession?.startRunning()
        }
    }
    
    func stopSession() {
        captureSession?.stopRunning()
    }
    
    func toggleTorch() {
        guard let device = torchDevice, device.hasTorch else { return }
        
        do {
            try device.lockForConfiguration()
            device.torchMode = isTorchOn ? .off : .on
            isTorchOn = !isTorchOn
            device.unlockForConfiguration()
        } catch {
            print("Error toggling torch: \(error)")
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
           let code = metadataObject.stringValue {
            scannedCode = code
            // Handle scanned code here
            print("Scanned QR Code: \(code)")
        }
    }
}

// Camera Preview
struct CameraPreview: UIViewRepresentable {
    let scanner: QRScannerViewModel
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        
        if let captureSession = scanner.captureSession {
            let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer.videoGravity = .resizeAspectFill
            view.layer.addSublayer(previewLayer)
            
            DispatchQueue.main.async {
                previewLayer.frame = view.bounds
            }
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        if let previewLayer = uiView.layer.sublayers?.first as? AVCaptureVideoPreviewLayer {
            previewLayer.frame = uiView.bounds
        }
    }
}

// QR Code Frame with Corner Brackets
struct QRCodeFrame: View {
    var body: some View {
        ZStack {
            // Top-left bracket
            VStack(alignment: .leading, spacing: 0) {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 30, height: 4)
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 4, height: 30)
            }
            .offset(x: -125, y: -125)
            
            // Top-right bracket
            VStack(alignment: .trailing, spacing: 0) {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 30, height: 4)
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 4, height: 30)
            }
            .offset(x: 125, y: -125)
            
            // Bottom-left bracket
            VStack(alignment: .leading, spacing: 0) {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 4, height: 30)
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 30, height: 4)
            }
            .offset(x: -125, y: 125)
            
            // Bottom-right bracket
            VStack(alignment: .trailing, spacing: 0) {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 4, height: 30)
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 30, height: 4)
            }
            .offset(x: 125, y: 125)
        }
    }
}

// Scooter QR View
struct ScooterQRView: View {
    var body: some View {
        ZStack {
            // Main scooter body
            VStack(spacing: 0) {
                // Handlebars
                HStack(spacing: 50) {
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color(white: 0.3))
                        .frame(width: 40, height: 3)
                    
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color(white: 0.3))
                        .frame(width: 40, height: 3)
                }
                .offset(y: -5)
                
                // Stem with red accent
                VStack(spacing: 0) {
                    // Screen/display
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color(white: 0.1))
                        .frame(width: 40, height: 30)
                    
                    // Stem body (red)
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.red)
                        .frame(width: 50, height: 100)
                }
                
                // Deck
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color(white: 0.2))
                    .frame(width: 180, height: 20)
                
                // Wheels
                HStack(spacing: 120) {
                    Circle()
                        .fill(Color(white: 0.15))
                        .frame(width: 60, height: 60)
                        .overlay(
                            Circle()
                                .stroke(Color.red, lineWidth: 2)
                                .frame(width: 60, height: 60)
                        )
                    
                    Circle()
                        .fill(Color(white: 0.15))
                        .frame(width: 60, height: 60)
                        .overlay(
                            Circle()
                                .stroke(Color.red, lineWidth: 2)
                                .frame(width: 60, height: 60)
                        )
                }
                .offset(y: -5)
            }
        }
    }
}

struct QRScannerScreen_Previews: PreviewProvider {
    static var previews: some View {
        QRScannerScreen()
    }
}

