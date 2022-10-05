//
//  Expo1900 - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var visitorCountLabel: UILabel!
    @IBOutlet weak var venueCityLabel: UILabel!
    @IBOutlet weak var durationEventLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    let labelMagicNumber = ": "
    var expoDescription: ExpoDescription? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initExpoInfo()
        updateViewData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func initExpoInfo() {
        guard let expoInfo: NSDataAsset = NSDataAsset.init(name: "exposition_universelle_1900") else {
            return
        }
        let jsonDecoder = JSONDecoder()

        do {
            self.expoDescription = try jsonDecoder.decode(ExpoDescription.self, from: expoInfo.data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateViewData() {
        if let expoInfo = expoDescription {
            titleLabel.text = expoInfo.title
            visitorCountLabel.text = labelMagicNumber + String(expoInfo.visitors)
            venueCityLabel.text = labelMagicNumber + expoInfo.location
            durationEventLabel.text = labelMagicNumber + expoInfo.duration
            descriptionLabel.text = expoInfo.description
        }
    }
}

