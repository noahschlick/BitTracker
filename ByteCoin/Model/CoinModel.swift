//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Noah Schlickeisen on 4/30/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel
{
    var rate: Double
    var asset_id_quote: String
    
    var rateString: String
    {
        return String(format: "%.2f", rate)
    }
}
