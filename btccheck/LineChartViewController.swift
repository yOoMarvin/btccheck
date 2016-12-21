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
    var months: [Double]!

    @IBOutlet weak var lineChartView: LineChartView!

    override func viewDidLoad() {
        super.viewDidLoad()
        //change back navigation color. the blue is aweful
        self.navigationController?.navigationBar.tintColor = UIColor.darkText
        
        //set dummy Data
        months = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        
        //build chart
        setChart(dataPoints: months, values: unitsSold)
        
        //animation and styling
        lineChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        lineChartView.xAxis.labelPosition = .bottom

        
        
        //init bitcoin history resource and call completion to get data
        let resource = HistoryResource()
        resource.fetchHistory {
            (response) in
            
            print(response.prices)
            print(response.dates)
            print(type(of: response.prices))
            print(type(of: response.dates))
        }
    }

    func setChart(dataPoints: [Double], values: [Double]) {
        //change line chart text
        lineChartView.noDataText = "We have to go back Marty, something went wrong!"
        
        //
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: dataPoints[i], y: values[i] )
            dataEntries.append(dataEntry)
        }
        //datasets
        let data = LineChartData()
        let dataSet = LineChartDataSet(values: dataEntries, label: "Units sold")
    
        //colors
        dataSet.colors = [UIColor(red:1.00, green:0.76, blue:0.03, alpha:1.0)]
        dataSet.circleColors = [UIColor(red:1.00, green:0.76, blue:0.03, alpha:1.0)]
        
        //add data set and show it
        data.addDataSet(dataSet)
        self.lineChartView.data = data
        
    }
}
