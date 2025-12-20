
import Foundation
import AVFoundation
import Vision
import UIKit
import Combine

class CameraManager: NSObject, ObservableObject {
    let session = AVCaptureSession()
    
    private let sessionQueue = DispatchQueue(label: "cameraSessionQueue")
    
    @Published var detectedLabel: String = "Detecting..."
    
    
    private var visionRequests = [VNRequest]()
    
    override init() {
        super.init()
        setupSession()
        setupVision()
    }
    
    private func setupSession() {
        sessionQueue.async {
            self.session.beginConfiguration()
            
            self.session.sessionPreset = .hd1280x720
            
            guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
                  let videoInput = try? AVCaptureDeviceInput(device: videoDevice) else {
                print("Camera Not found")
                return
            }
            
            if self.session.canAddInput(videoInput) {
                self.session.addInput(videoInput)
            }
            
            let videoOutput = AVCaptureVideoDataOutput()
            videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
            
            if self.session.canAddOutput(videoOutput) {
                self.session.addOutput(videoOutput)
            }
            
            self.session.commitConfiguration()
        }
    }
    
    // YOLO11n
    private func setupVision() {
        do {
            // Set up model (yolo11n)
            let config = MLModelConfiguration()
            let model = try VNCoreMLModel(for: yolo11n(configuration: config).model)
            
            let request = VNCoreMLRequest(model: model) { [weak self] request, error in
                self?.processObservations(for: request, error: error)
            }
            
            // Squared imagen like YOLO
            request.imageCropAndScaleOption = .centerCrop
            self.visionRequests = [request]
            
        } catch {
            print(" Error set up YOLO: \(error)")
        }
    }
    
    // Processing information captured by YOLO
    private func processObservations(for request: VNRequest, error: Error?) {
        DispatchQueue.main.async {
            guard let results = request.results as? [VNRecognizedObjectObservation] else {
                self.detectedLabel = "NONE..."
                return
            }
            
            // If detect something, we take the first result (it is the most accurate)
            if let firstResult = results.first {
                let identifier = firstResult.labels.first?.identifier ?? "Unknown"
                let confidence = Int(firstResult.confidence * 100)
                
                // Update text
                self.detectedLabel = "\(identifier) (\(confidence)%)"
            } else {
                self.detectedLabel = "..."
            }
        }
    }
    
    // Control Functions
    func start() {
        sessionQueue.async {
            if !self.session.isRunning { self.session.startRunning() }
        }
    }
    
    func stop() {
        sessionQueue.async {
            if self.session.isRunning { self.session.stopRunning() }
        }
    }
}

// Bridge
extension CameraManager: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .right)
        
        do {
            try imageRequestHandler.perform(self.visionRequests)
        } catch {
            print("Error al ejecutar visión: \(error)")
        }
    }
}
