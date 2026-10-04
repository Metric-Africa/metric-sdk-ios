import SwiftUI
import MetricSDK

@main
struct swift_ui_exampleApp: App {
    
    init() {
        // Initialize the SDK with your developer keys
        Metric.initialize(clientKey: "YOUR_CLIENT_KEY", secretKey: "YOUR_SECRET_KEY")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
