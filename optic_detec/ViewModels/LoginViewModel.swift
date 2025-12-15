import Foundation
import SwiftUI
import Combine

class LoginViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var licensePlate: String = ""
    
    
    @Published var errorMessage: String? = nil
    
    func validate() -> Bool {
        if username.trimmingCharacters(in: .whitespaces).isEmpty {
                    errorMessage = "Por favor, introduce un nombre para continuar."
                    return false
        }
        errorMessage = nil
        return true
    }
}

