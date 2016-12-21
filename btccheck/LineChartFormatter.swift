//
//  LineChartFormatter.swift
//  btccheck
//
//  Created by Marvin Messenzehl on 21.12.16.
//  Copyright © 2016 Marvin Messenzehl. All rights reserved.
//

import Foundation
import UIKit
import Charts

@objc(LineChartFormatter)
class LineChartFormatter: NSObject, IAxisValueFormatter {
    
    var mValues: [String]!
    
    func setArray(array: [String]) -> (){
        mValues = array
    }
    
    var months: [String]! = ["1", "2", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct"]
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return mValues[Int(value)]
    }
}
