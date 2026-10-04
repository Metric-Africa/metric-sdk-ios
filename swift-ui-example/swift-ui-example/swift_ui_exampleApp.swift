import SwiftUI
import MetricSDK

@main
struct swift_ui_exampleApp: App {
    
    init() {
        // Initialize the SDK with your developer keys
        Metric.initialize(clientKey: "mtbftwdky8nmDnvvPaJ5", secretKey: "RMp9LLXrRQYcYplZVFowox9PgXpgvT0TAKeiVfKmgQjVh")
        
        let config = MetricSDKConfiguration()
        config.environment = .production
        config.brandPrimaryColor = "#000000"
        config.dataMode = .extended
        MetricService.configure(config)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
