import Foundation
import SwiftData

@Model
class Detection {
    var id: UUID
    var timestamp: Date
    var confidence: Double
    
    var user: User?

    init(type: String, confidence: Double) {
        self.id = UUID()
        self.timestamp = Date()
        self.confidence = confidence
    }
}
