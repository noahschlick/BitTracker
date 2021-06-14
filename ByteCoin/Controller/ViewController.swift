//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    // Initialize the CoinManager object
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set view controller as the data source for the picker
        currencyPicker.dataSource = self
        
        // Set viewcontroller delegate class to its self
        currencyPicker.delegate = self
        
        // Delegate for updateing the coin data
        coinManager.delegate = self
        
    }

}

//MARK: - UIPickerDataSource

extension ViewController: UIPickerViewDataSource
{
    public func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return coinManager.currencyArray.count
    }
}

//MARK: - UIPickerViewDelegate
extension ViewController: UIPickerViewDelegate
{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return coinManager.currencyArray[row]
    }
    
    // This will get called every time the user scrolls the picker
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        let selectedCurency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurency)
    }
}

//MARK: - DidUpdateWeather
extension ViewController: CoinManagerDelegate
{
    func didFailWithError(error: Error)
    {
        print(error)
    }
    
    func didUpdateValue(_ coinManager: CoinManager, value: CoinModel)
    {
        DispatchQueue.main.async
        {
            self.bitcoinLabel.text = value.rateString
            self.currencyLabel.text = value.asset_id_quote
        }
    }
}


