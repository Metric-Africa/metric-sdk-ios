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
    }
    
    @IBAction func launchSDKPressed(_ sender: Any) {
        let launcher = LaunchSDK(token: "<token here>")
        launcher.modalPresentationStyle = .overCurrentContext
        launcher.modalTransitionStyle = .crossDissolve
        present(launcher, animated: true, completion:nil)
    }
    
}

