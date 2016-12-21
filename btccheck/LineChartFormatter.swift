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
    
    //declare array
    var mValues: [String]!
    
    //function for set the array. values are given back later
    func setArray(array: [String]) -> (){
        mValues = array
    }
    
    //Format values for graph axis
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return mValues[Int(value)]
    }
}
