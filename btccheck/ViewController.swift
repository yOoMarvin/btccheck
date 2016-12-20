//
//  ViewController.swift
//  btccheck
//
//  Created by Marvin Messenzehl on 19.12.16.
//  Copyright © 2016 Marvin Messenzehl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let resource = BitcoinResource()
        resource.fetchReport {
            (response) in
            
            print(response.price)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

