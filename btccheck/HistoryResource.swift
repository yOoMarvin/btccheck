//
//  HistoryResource.swift
//  btccheck
//
//  Created by Marvin Messenzehl on 20.12.16.
//  Copyright © 2016 Marvin Messenzehl. All rights reserved.
//

import Foundation

class HistoryResource{
    //build URL
    private func buildUrlString() -> String? {
        //https://apiv2.bitcoinaverage.com/indices/global/history/BTCUSD?period=alltime&format=json
        let host = "apiv2.bitcoinaverage.com"
        let path = "indices/global/history"
        let currency = "BTCUSD"
        let params = "period=alltime&format=json"
        
        return "https://\(host)/\(path)/\(currency)?\(params)"
    }
    
    //Download data for bitcoin history
    func fetchHistory(completion: @escaping (_ response: HistoryResponse) -> ()) {
        
        let queue = DispatchQueue.global(qos: .background)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        //async download
        queue.async {
            guard let url = self.buildUrlString(),
                let urlObj = URL(string: url) else {
                    print("problem with url")
                    return
            }
            let task = session.dataTask(with: urlObj, completionHandler: { (data, response, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                guard let data = data,
                    let apiResponse = self.createHistoryResponse(fromData: data) else {
                        print("no data?")
                        return
                }
                DispatchQueue.main.async {
                    completion(apiResponse)
                }
            })
            task.resume()
        }
        
        
    }

    
    
    private func createHistoryResponse(fromData: Data) -> HistoryResponse?{
        guard let jsonArray = parseJson(data: fromData) else {
            print("problem with json processing")
            return nil
        }
        
        var dates: [String] = []
        var prices: [Double] = []
        
        for object in jsonArray{
            let avg = object["average"] as! Double
            let time = object["time"] as! String
            let index = time.index(time.startIndex, offsetBy: 10)
            
            prices.append(avg)
            dates.append(time.substring(to: index))
        }
        
        prices = prices.reversed()
        dates = dates.reversed()
        
        //build response
        let response = HistoryResponse(dates: dates, prices: prices)
        return response
    }

    
    private func parseJson(data: Data) -> [[String:Any]]?{
        do {
            let jsonArray = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String:Any]]
            return jsonArray
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    
    
    //TODO:
    //try to use the Bitcoin Resource and just extend it
    
    
}
