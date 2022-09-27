//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Emmanuel George on 22/08/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation
struct CoinModel {
    let rate:Double
    let crptoCurrency:String
    let currency:String
    var rateOfCryptoString:String{
        return String(format: "%.2f", rate)
    }
  
}
