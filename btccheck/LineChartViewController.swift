//
//  LineChartViewController.swift
//  btccheck
//
//  Created by Marvin Messenzehl on 20.12.16.
//  Copyright © 2016 Marvin Messenzehl. All rights reserved.
//

import UIKit
import Charts

class LineChartViewController: UIViewController {
    @IBOutlet weak var lineChartView: LineChartView!

    override func viewDidLoad() {
        super.viewDidLoad()
        lineChartView.noDataText = "Dude, we have to go back, something went wrong!"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
