//
//  ViewController.swift
//  RangeControlExample
//
//  Created by Alexey Ledovskiy on 3/28/19.
//  Copyright © 2019 Alexey Ledovskiy. All rights reserved.
//

import UIKit
import RangeControl

class ViewController: UIViewController {
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var upLabel: UILabel!
    
    @IBOutlet weak var rangeControl: RangeControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let imageView = UIImageView(image: UIImage(named: "testImage"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        rangeControl.backgroundView.addArrangedSubview(imageView)
        lowLabel.text = rangeControl.lowValue.description
        upLabel.text = rangeControl.upValue.description
        rangeControl.onRangeValueChanged = { (low,up) in
            self.lowLabel.text = low.description
            self.upLabel.text = up.description
            print("Low: \(low) up: \(up)")
        }
    }
}

