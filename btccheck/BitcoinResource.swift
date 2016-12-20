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
        /*
        guard let changeDict = jsonDict["changes"]?["percent"] as? NSDictionary else{
            print("problem with reading dicts")
            return nil
        }
         */
        
        guard let price = jsonDict["ask"] as? Double else{
            print("problem with reading values")
            return nil
        }
        
        let response = BitcoinResponse(price: price)
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



