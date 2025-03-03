import SwiftUI

enum SessionAlerts: Identifiable {
    case zeroTimeAlert
    case colorAlert
    case completionAlert
    // Add future alerts here
    
    var id: Self { self } // Conforming to Identifiable
    
    var title: String {
        switch self {
        case .zeroTimeAlert:
            return "Invalid Time"
        case .colorAlert:
            return "Invalid Color Selection"
        case .completionAlert:
            return "Congratulations"
        }
    }
    
    var message: String {
        switch self {
        case .zeroTimeAlert:
            return "Initial time cannot be zero. Please set a valid time before enabling interval session"
        case .colorAlert:
            return "Please select at least two colors"
        case .completionAlert:
            return "Congrats you have successfully completed a session"
        }
    }
}
