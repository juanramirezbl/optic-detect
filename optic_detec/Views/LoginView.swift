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
            //create user
            let newUser = User(name: viewModel.username)
            
            // save in SwiftData
            modelContext.insert(newUser)
            currentUserId = newUser.id.uuidString
            
            // get in
            isUserLoggedIn = true
        }
    }
}
