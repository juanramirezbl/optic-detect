import SwiftUI
import SwiftData

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    
    @Environment(\.modelContext) private var modelContext
    @AppStorage("isUserLoggedIn") private var isUserLoggedIn: Bool = false
    @AppStorage("currentUserId") private var currentUserId: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Login").font(.title)
            
            TextField("Escribe tu nombre", text: $viewModel.username)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            TextField("Matrícula (Ej: 1234 LLL)", text: $viewModel.licensePlate)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
                .textInputAutocapitalization(.characters)
            
            if let error = viewModel.errorMessage {
                Text(error).foregroundColor(.red)
            }
            
            Button("Entrar") {
                loginUser()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
    
    func loginUser() {
            if viewModel.validate() {
                let newUser = User(name: viewModel.username, licensePlate: viewModel.licensePlate)
                
                modelContext.insert(newUser)
                
                try? modelContext.save()
                
                currentUserId = newUser.id.uuidString
                isUserLoggedIn = true
            }
        }
}
