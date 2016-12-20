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

