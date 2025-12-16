import SwiftUI
import SwiftData

@main
struct opticApp: App {
    @AppStorage("isUserLoggedIn") private var isUserLoggedIn: Bool = false
    
    var body: some Scene {
        
        WindowGroup {
            if isUserLoggedIn {
                Text("¡Bienvenido!")
                    .font(.largeTitle)
                    .modelContainer(for: [User.self, Detection.self])
            } else {
                LoginView()
                    .modelContainer(for: [User.self, Detection.self])
            }
        }
    }
}
