//
//  ViewController.swift
//  Criptomoeda
//
//  Created by Lucas A. dos Santos on 11/03/2019.
//  Copyright © 2019 Lucas A. dos Santos. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var criptoCurrency = [""]
    var currency = [""]

    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        criptoCurrency = ["BTC", "ETH", "XRP", "BCH"]
        currency = ["USD", "EUR", "JPY", "CHF"]
        // Do any additional setup after loading the view, typically from a nib.
        
        picker.delegate = self
        picker.dataSource = self
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return criptoCurrency.count
        }
        else {
            return currency.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return criptoCurrency[row]
        }
        else {
            return currency[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        getPrice(criptoCurrency: criptoCurrency[picker.selectedRow(inComponent: 0)], currency: currency[picker.selectedRow(inComponent: 1)])
    }
    
    func getPrice(criptoCurrency: String, currency: String) {
        if let url = URL(string: "https://min-api.cryptocompare.com/data/price?fsym=" + criptoCurrency + "&tsyms=" + currency) {
            URLSession.shared.dataTask(with: url) {
                (data, response, error) in
                print("connected")
                if let data = data {
                    if let json = try? JSONSerialization.jsonObject(with: data, options:[]) as? [String:Double] {
                        if let jsonDictionary = json {
                            DispatchQueue.main.sync {
                                if let price = jsonDictionary[currency] {
                                    let formatter = NumberFormatter()
                                    formatter.currencyCode = currency
                                    formatter.numberStyle = .currency
                                    let formattedPrice = formatter.string(from: NSNumber(value: price))
                                    self.resultLabel.text = formattedPrice
                                }
                            }
                            
                        }

                    }
                    
                }
                else {
                    print("wrong =(")
                }
            }.resume()
            
        }
    }


}

