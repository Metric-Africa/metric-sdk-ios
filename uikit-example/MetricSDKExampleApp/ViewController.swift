import UIKit
import MetricSDK

class ViewController: UIViewController {

    let statusLabel = UILabel()
    let verifyButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // Listen for the verification outcome notification
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleVerificationOutcome(_:)),
            name: NSNotification.Name(NotificationKeys.VERIFICATION_COMPLETE),
            object: nil
        )
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        statusLabel.text = "Ready to verify"
        statusLabel.textAlignment = .center
        statusLabel.numberOfLines = 0
        statusLabel.textColor = .secondaryLabel
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        verifyButton.setTitle("Verify Identity", for: .normal)
        verifyButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        verifyButton.backgroundColor = .systemBlue
        verifyButton.setTitleColor(.white, for: .normal)
        verifyButton.layer.cornerRadius = 12
        verifyButton.translatesAutoresizingMaskIntoConstraints = false
        verifyButton.addTarget(self, action: #selector(verifyTapped), for: .touchUpInside)
        
        view.addSubview(statusLabel)
        view.addSubview(verifyButton)
        
        NSLayoutConstraint.activate([
            statusLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            verifyButton.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 40),
            verifyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            verifyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            verifyButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func verifyTapped() {
        // Ensure you replace "YOUR_TOKEN_HERE" with a valid verification token
        let launcher = LaunchMetricSDK(token: "YOUR_TOKEN_HERE")
        launcher.modalPresentationStyle = .overCurrentContext
        launcher.modalTransitionStyle = .crossDissolve
        
        self.present(launcher, animated: true, completion: nil)
    }
    
    @objc private func handleVerificationOutcome(_ notification: Notification) {
        guard let outcome = notification.object as? VerificationOutcome else { return }
        
        switch outcome {
        case .success(let payload):
            statusLabel.text = "✅ Success!\n\(String(describing: payload))"
        case .failed(let reason):
            statusLabel.text = "❌ Failed: \(reason)"
        default:
            statusLabel.text = "⚠️ Unknown outcome"
        }
    }
}
