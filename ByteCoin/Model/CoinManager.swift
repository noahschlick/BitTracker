//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate
{
    func didUpdateValue(_ coinManager: CoinManager, value: CoinModel)
    func didFailWithError(error: Error)
}

struct CoinManager {
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC/"
    let apiKey = "846871C2-F7CB-43BB-ADBA-908532F6E543"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CoinManagerDelegate?
    
    func getCoinPrice(for currency: String)
    {
        let urlString = baseURL + "\(currency)?apiKey=\(apiKey)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String)
    {
        if let url = URL(string: urlString)
        {
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with:url) { (data, response, error) in
                
                if error != nil
                {
                    print(error!)
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data
                {
                    if let value = self.parseJSON(safeData)
                    {
                        self.delegate?.didUpdateValue(self, value: value)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ coinData: Data) -> CoinModel?
    {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            
            //Gate data form coin data
            let rate = decodedData.rate
            let currency = decodedData.asset_id_quote
            let coinModel = CoinModel(rate: rate, asset_id_quote: currency)
            return coinModel

        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    

    
}
