//
//  BitcoinResource.swift
//  btccheck
//
//  Created by Marvin Messenzehl on 19.12.16.
//  Copyright © 2016 Marvin Messenzehl. All rights reserved.
//

import Foundation

class BitcoinResource {
    
    //build the URL
    private func buildUrlString() -> String? {
        let host = "apiv2.bitcoinaverage.com"
        let path = "indices/global/ticker"
        let currency = "BTCUSD"
        
        return "https://\(host)/\(path)/\(currency)"
    }
    
    //public interface:
    //download the bitcoin data
    func fetchReport(completion: @escaping (_ response: BitcoinResponse) -> ()) {
        
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
                      let apiResponse = self.createResponse(fromData: data) else {
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
    
    
    //
    private func createResponse(fromData: Data) -> BitcoinResponse?{
        guard let jsonDict = parseJson(data: fromData) else {
            print("problem with json processing")
            return nil
        }
        
        //read dicts
        let openDict = jsonDict["open"] as! [String:Any]
        let changesDict = jsonDict["changes"] as! [String:Any]
        let percentDict = changesDict["percent"] as! [String:Any]
        let avgDict = jsonDict["averages"] as! [String:Any]

        //read data from the dicts
        let price = jsonDict["ask"] as! Double
        let high = jsonDict["high"] as! Double
        let low = jsonDict["low"] as! Double
        let open = openDict["day"] as! Double
        let avg = avgDict["week"] as! Double
        let volume = jsonDict["volume"] as! Double
        let change = percentDict["day"] as! Double
        
        //build response
        let response = BitcoinResponse(price: price, high: high, low: low, open: open, avg: avg, volume: volume, change: change)
        return response
    }
    
    private func parseJson(data: Data) -> NSDictionary?{
        do {
        let jsonDict = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
            return jsonDict
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}



