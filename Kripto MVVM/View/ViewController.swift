//
//  ViewController.swift
//  Kripto MVVM
//
//  Created by Noyan Çepikkurt on 27.10.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    private var cryptoListViewModel : CryptoListModel!
    
    var colorArray = [UIColor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.colorArray = [
            UIColor(red: 65/255, green: 55/255, blue: 82/255, alpha: 1.0),
            UIColor(red: 104/255, green: 25/255, blue: 99/255, alpha: 1.0),
            UIColor(red: 52/255, green: 36/255, blue: 44/255, alpha: 1.0),
            UIColor(red: 89/255, green: 89/255, blue: 55/255, alpha: 1.0),
            UIColor(red: 102/255, green: 120/255, blue: 67/255, alpha: 1.0),
            UIColor(red: 160/255, green: 95/255, blue: 99/255, alpha: 1.0),
        ]
        
        getData()
        
        }

    func getData() {
        let url = URL(string:"https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")
        
        WebService().downloadCurrencies(url: url!) { (cryptos) in
            if let cryptos = cryptos {
                
                self.cryptoListViewModel = CryptoListModel(cryptoCurrencyList: cryptos)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cryptoListViewModel == nil ? 0 : self.cryptoListViewModel.numberOfRowsInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoCell", for: indexPath) as! CryptoTableViewCell
       
        let cryptoViewModel = self.cryptoListViewModel.cryptoAtIndex(indexPath.row)
        
        cell.priceText.text = cryptoViewModel.price
        cell.currencyText.text = cryptoViewModel.name
        cell.backgroundColor = self.colorArray[indexPath.row % 6]
        
        return cell
    }
    
}

