//
//  ViewController.swift
//  btccheck
//
//  Created by Marvin Messenzehl on 19.12.16.
//  Copyright © 2016 Marvin Messenzehl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var avgLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        //set current date
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyy"
        dateLabel.text = formatter.string(from: date)
        
        //init bitcoin resource and call completion to get data
        let resource = BitcoinResource()
        resource.fetchReport {
            (response) in
            
            //write data and make label visible
            self.priceLabel.text = "\(response.price) $"
            self.priceLabel.isHidden = false
            
            self.openLabel.text = "\(response.open) $"
            self.highLabel.text = "\(response.high) $"
            self.lowLabel.text = "\(response.low) $"
            self.changeLabel.text = "\(response.change) %"
            if response.change > 0 {
                self.changeLabel.textColor = UIColor(red:0.18, green:0.65, blue:0.20, alpha:1.0)
                self.changeLabel.text = "+ \(response.change) %"
            } else {
                self.changeLabel.textColor = UIColor(red:0.65, green:0.18, blue:0.18, alpha:1.0)
                self.changeLabel.text = "- \(response.change) %"
            }
            self.avgLabel.text = "\(response.avg) $"
            self.volumeLabel.text = "\(response.volume)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

