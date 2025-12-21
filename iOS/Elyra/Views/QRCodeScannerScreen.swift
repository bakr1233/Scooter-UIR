import SwiftUI
import AVFoundation

struct QRCodeScannerScreen: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var scanner = QRCodeScanner()
    @State private var isFlashlightOn = false
    @State private var showManualCodeEntry = false
    
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
                    
                    // Header Text
                    Text("scan the QR code")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    
                    // Scooter Visualization
                    ScooterQRView()
                        .frame(height: geometry.size.height * 0.15)
                        .padding(.top, 30)
                    
                    Spacer()
                    
                    // QR Code Scanner Area
                    ZStack {
                        // Camera Preview
                        QRCodeScannerView(scanner: scanner)
                            .frame(width: 250, height: 250)
                            .cornerRadius(20)
                            .overlay(
                                // Red corner brackets
                                ZStack {
                                    // Top-left corner
                                    Path { path in
                                        path.move(to: CGPoint(x: 0, y: 20))
                                        path.addLine(to: CGPoint(x: 0, y: 0))
                                        path.addLine(to: CGPoint(x: 20, y: 0))
                                    }
                                    .stroke(Color.red, lineWidth: 4)
                                    
                                    // Top-right corner
                                    Path { path in
                                        path.move(to: CGPoint(x: 250 - 20, y: 0))
                                        path.addLine(to: CGPoint(x: 250, y: 0))
                                        path.addLine(to: CGPoint(x: 250, y: 20))
                                    }
                                    .stroke(Color.red, lineWidth: 4)
                                    
                                    // Bottom-left corner
                                    Path { path in
                                        path.move(to: CGPoint(x: 0, y: 250 - 20))
                                        path.addLine(to: CGPoint(x: 0, y: 250))
                                        path.addLine(to: CGPoint(x: 20, y: 250))
                                    }
                                    .stroke(Color.red, lineWidth: 4)
                                    
                                    // Bottom-right corner
                                    Path { path in
                                        path.move(to: CGPoint(x: 250 - 20, y: 250))
                                        path.addLine(to: CGPoint(x: 250, y: 250))
                                        path.addLine(to: CGPoint(x: 250, y: 250 - 20))
                                    }
                                    .stroke(Color.red, lineWidth: 4)
                                }
                            )
                    }
                    .frame(height: geometry.size.height * 0.35)
                    
                    Spacer()
                    
                    // Bottom Action Bar
                    HStack {
                        Spacer()
                        
                        // Manual Code Entry Button
                        Button(action: {
                            showManualCodeEntry = true
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
                        
                        // Flashlight Button
                        Button(action: {
                            isFlashlightOn.toggle()
                            scanner.toggleFlashlight(isOn: isFlashlightOn)
                        }) {
                            Image(systemName: isFlashlightOn ? "flashlight.on.fill" : "flashlight.off.fill")
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
            .navigationDestination(isPresented: $showManualCodeEntry) {
                ManualCodeEntryScreen()
            }
            .onAppear {
                scanner.startScanning()
            }
            .onDisappear {
                scanner.stopScanning()
            }
        }
    }
}

// Scooter Visualization for QR Screen
struct ScooterQRView: View {
    var body: some View {
        ZStack {
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
                
                // Stem (Red)
                VStack(spacing: 0) {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.red)
                        .frame(width: 50, height: 80)
                }
                
                // Deck
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color(white: 0.2))
                    .frame(width: 150, height: 20)
                
                // Wheels
                HStack(spacing: 100) {
                    Circle()
                        .fill(Color(white: 0.15))
                        .frame(width: 50, height: 50)
                        .overlay(
                            Circle()
                                .stroke(Color.red, lineWidth: 2)
                                .frame(width: 50, height: 50)
                        )
                    
                    Circle()
                        .fill(Color(white: 0.15))
                        .frame(width: 50, height: 50)
                        .overlay(
                            Circle()
                                .stroke(Color.red, lineWidth: 2)
                                .frame(width: 50, height: 50)
                        )
                }
                .offset(y: -5)
            }
        }
    }
}

// QR Code Scanner View
struct QRCodeScannerView: UIViewRepresentable {
    let scanner: QRCodeScanner
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        
        let captureSession = scanner.captureSession
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        
        DispatchQueue.main.async {
            previewLayer.frame = view.bounds
            view.layer.addSublayer(previewLayer)
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        if let layer = uiView.layer.sublayers?.first as? AVCaptureVideoPreviewLayer {
            layer.frame = uiView.bounds
        }
    }
}

// QR Code Scanner Manager
class QRCodeScanner: NSObject, ObservableObject, AVCaptureMetadataOutputObjectsDelegate {
    let captureSession = AVCaptureSession()
    private var videoDevice: AVCaptureDevice?
    
    override init() {
        super.init()
        setupCamera()
    }
    
    private func setupCamera() {
        guard let videoCaptureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            return
        }
        
        videoDevice = videoCaptureDevice
        
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            return
        }
    }
    
    func startScanning() {
        if !captureSession.isRunning {
            DispatchQueue.global(qos: .userInitiated).async {
                self.captureSession.startRunning()
            }
        }
    }
    
    func stopScanning() {
        if captureSession.isRunning {
            captureSession.stopRunning()
        }
    }
    
    func toggleFlashlight(isOn: Bool) {
        guard let device = videoDevice, device.hasTorch else { return }
        
        do {
            try device.lockForConfiguration()
            if isOn {
                try device.setTorchModeOn(level: 1.0)
            } else {
                device.torchMode = .off
            }
            device.unlockForConfiguration()
        } catch {
            print("Error toggling flashlight: \(error)")
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            
            // Handle scanned QR code
            print("Scanned QR Code: \(stringValue)")
            // You can add navigation or action here when QR code is scanned
        }
    }
}

struct QRCodeScannerScreen_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeScannerScreen()
    }
}

