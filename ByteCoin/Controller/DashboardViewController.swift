//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import Firebase
class DashboardViewController: UIViewController{
    
    var coinManager = CoinManager()
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var ethLabel: UILabel!
    @IBOutlet weak var dogeLabel: UILabel!
    @IBOutlet weak var bnbLabel: UILabel!
    @IBOutlet weak var btcCurrencyLabel: UILabel!
    @IBOutlet weak var ethCurrencyLabel: UILabel!
    @IBOutlet weak var dogeCurrencyLabel: UILabel!
    @IBOutlet weak var bnbCurrencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        coinManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
 
        navigationItem.hidesBackButton = true
    }
}
//MARK: - CoinManagerDelegate
extension DashboardViewController: CoinManagerDelegate {
    func didUpdateCoinPrice(_ coinManager: CoinManager, coin: CoinModel) {
        DispatchQueue.main.async {
            self.btcCurrencyLabel.text = coin.currency
            self.bnbCurrencyLabel.text = coin.currency
            self.dogeCurrencyLabel.text = coin.currency
            self.ethCurrencyLabel.text = coin.currency
            if coin.crptoCurrency=="BTC"{
                self.bitcoinLabel.text = coin.rateOfCryptoString
            }
            else if coin.crptoCurrency=="DOGE"{
                self.dogeLabel.text = coin.rateOfCryptoString
            }
            
            else if coin.crptoCurrency=="ETH"{
                self.ethLabel.text = coin.rateOfCryptoString
            }
            
            else{
                self.bnbLabel.text = coin.rateOfCryptoString
            }
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - UIPickerView DataSource & Delegate
extension DashboardViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
          return 1
      }
      func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
          return coinManager.currencyArray.count
      }
      func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
          return coinManager.currencyArray[row]
      }
      func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
          let selectedCurrency = coinManager.currencyArray[row]
          coinManager.getCryotoPrice(for: selectedCurrency)

      }
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
    }
}
