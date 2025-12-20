import SwiftUI

struct DashboardView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var cameraManager = CameraManager()
    
    @AppStorage("currentUserId") private var currentUserId: String = ""
    @AppStorage("isUserLoggedIn") private var isUserLoggedIn: Bool = false
    
    var body: some View {
        ZStack {
            CameraPreview(cameraManager: cameraManager)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("Detectando:")
                        .foregroundColor(.white)
                    Text(cameraManager.detectedLabel)
                        .font(.title2)
                        .bold()
                        .foregroundColor(.yellow)
                    Spacer()
                }
                .padding()
                .background(Color.black.opacity(0.5))
                
                Spacer()
                
                Button(action: {
                    cameraManager.stop()
                    dismiss()
                }) {
                    Text("Exit")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.bottom, 50)
            }
        }
        .onAppear {
            cameraManager.start()
        }
        .onDisappear {
            cameraManager.stop()
        }
    }
}
