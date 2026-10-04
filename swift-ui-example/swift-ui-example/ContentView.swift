import SwiftUI
import MetricSDK

struct ContentView: View {
    @State private var showVerification = false
    @State private var statusMessage = "Ready to verify"
    
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: "person.crop.circle.badge.checkmark")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
            
            Text("Metric SDK Example")
                .font(.title)
                .fontWeight(.bold)
            
            Text(statusMessage)
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button(action: {
                showVerification = true
            }) {
                Text("Verify Identity")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 40)
        }
        .padding()
        // Ensure you replace "YOUR_TOKEN_HERE" with a valid verification token
        .metricVerification(isPresented: $showVerification, token: "LP253PUSV") { outcome in
            switch outcome {
            case .success(let payload):
                statusMessage = "✅ Success!\n\(String(describing: payload))"
            case .failed(let reason):
                statusMessage = "❌ Failed: \(reason)"
            default:
                statusMessage = "⚠️ Unknown outcome"
            }
        }
    }
}

#Preview {
    ContentView()
}
