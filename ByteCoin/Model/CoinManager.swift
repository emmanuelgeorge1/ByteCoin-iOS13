//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation
protocol CoinManagerDelegate{
    func didUpdateCoinPrice(_ coinManager: CoinManager , coin:CoinModel)
    func didFailWithError(error:Error)
}
struct CoinManager {
    
    let btcBaseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let bnbBaseURL = "https://rest.coinapi.io/v1/exchangerate/BNB"
    let dogeBaseURL = "https://rest.coinapi.io/v1/exchangerate/DOGE"
    let ethBaseURL = "https://rest.coinapi.io/v1/exchangerate/ETH"
    let apiKey = "431D1DE0-41E9-4B4E-AE52-5F0B373E86FB"
    var delegate:CoinManagerDelegate?
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    
    func getCryotoPrice(for currency:String){
        let btcUrlString = "\(btcBaseURL)/\(currency)?apikey=\(apiKey)"
        let dogeUrlString = "\(dogeBaseURL)/\(currency)?apikey=\(apiKey)"
        let bnbUrlString = "\(bnbBaseURL)/\(currency)?apikey=\(apiKey)"
        let ethUrlString = "\(ethBaseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(with: btcUrlString)
        performRequest(with: ethUrlString)
        performRequest(with: bnbUrlString)
        performRequest(with: dogeUrlString)

        
    }
    func performRequest(with urlString: String) {
        
        //1.  create the URL? (optional)
        
        if let url = URL(string: urlString){
            
            // 2.  create URL Session- the thing that performs like a browser (default)
            
            let session = URLSession(configuration: .default)
            
            // 3.  give session a task;  task waits for data, so uses completion handler
            
            //     as a function()
            
            let task = session.dataTask(with: url) { data, response, error in
                //check for errors here
                
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    print(error!)
                    
                    return  //exit failed
                }
                //optional binding of data
                if let safeData = data {
                    //look at data in web data format utc8
                    
                    if let coin = self.parseJSON( safeData){
                        self.delegate?.didUpdateCoinPrice(self, coin: coin)
                    }
                }
            }
            // 4.  start the task; "resume" because task is initialized as "suspended"
            task.resume()
        }
    }
    func parseJSON(_ coinData:Data )->CoinModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let priceOfCrypto = decodedData.rate
            let crptoCurrency = decodedData.asset_id_base
            let currency = decodedData.asset_id_quote
            print(priceOfCrypto)
            print(crptoCurrency)
            print(currency)
            let coin = CoinModel(rate: priceOfCrypto, crptoCurrency: crptoCurrency, currency: currency)
            return coin
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
