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
    var prices: [Double] = []
    var dates: [String] = []

    @IBOutlet weak var lineChartView: LineChartView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //change 'back' navigation color. the blue is aweful
        self.navigationController?.navigationBar.tintColor = UIColor.darkText
        
        //init bitcoin history resource and call completion to get data
        let resource = HistoryResource()
        resource.fetchHistory {
            (response) in
            
            self.prices = response.prices
            self.dates = response.dates
            
            
            //build chart
            self.setChart(dataPoints: self.dates, values: self.prices)
        }
        
        
        //animation and styling
        lineChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.rightAxis.enabled = false
        
        //change line chart text
        lineChartView.noDataText = "Hold still! I'm drawing this graph for you!"
        lineChartView.noDataFont = UIFont(name: "Avenir Next", size: 23)
        lineChartView.chartDescription?.enabled = false
    }

    
    
    func setChart(dataPoints: [String], values: [Double]) {
        let formato:LineChartFormatter = LineChartFormatter()
        formato.setArray(array: self.dates)
        let xaxis:XAxis = XAxis()
        
        //
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i] )
            dataEntries.append(dataEntry)
            formato.stringForValue(Double(i), axis: xaxis)
        }
        xaxis.valueFormatter = formato

        
        //datasets
        let data = LineChartData()
        let dataSet = LineChartDataSet(values: dataEntries, label: "Bitcoin price in $")
    
        //colors
        dataSet.colors = [UIColor(red:1.00, green:0.76, blue:0.03, alpha:1.0)]
        //dataSet.circleColors = [UIColor(red:1.00, green:0.76, blue:0.03, alpha:1.0)]
        
        //Disable values and circles, because of data size
        dataSet.drawCirclesEnabled = false
        dataSet.drawValuesEnabled = false
        
        //add data set and show it
        data.addDataSet(dataSet)
        self.lineChartView.data = data
        
        self.lineChartView.xAxis.valueFormatter = xaxis.valueFormatter
        
    }
}
