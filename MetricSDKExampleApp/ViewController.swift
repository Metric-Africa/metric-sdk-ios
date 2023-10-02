//
//  ViewController.swift
//  MetricSDKExampleApp
//
//  Created by Nii on 02/09/2023.
//

import UIKit
import MetricSDK

class ViewController: UIViewController {
    
    let config = MetricSDKConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config.environment = Environment.sandbox
        config.brandLogoImageUrl = "htttps://example/image.png"
        config.brandPrimaryColor = "#E36239"
        MetricService.configure(config)
        MetricNotificationManager.shared.addObserver(observer: self,
                                                     selector: #selector(handleVerificationOutcome),
                                                     name: NotificationKeys.VERIFICATION_COMPLETE)
        
    }
    
    @IBAction func launchSDKPressed(_ sender: Any) {
        let launcher = LaunchMetricSDK(token: "<token here>")
        launcher.modalPresentationStyle = .overCurrentContext
        launcher.modalTransitionStyle = .crossDissolve
        present(launcher, animated: true, completion:nil)
    }
    
    @objc func handleVerificationOutcome(_ notification: Notification) {
        if let outcome = notification.object as? VerificationOutcome {
            switch outcome {
            case .success:
                //update your UI, etc..
                print("Verification successful")
            case .failed(let reason):
                //update your UI, etc..
                print("Session failed: \(reason)")
            default:
                break
            }
        }
    }
    
}

