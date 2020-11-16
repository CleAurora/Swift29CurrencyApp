//
//  ViewController.swift
//  CurrencyApp
//
//  Created by Cleís Aurora Pereira on 11/11/20.
//

import UIKit
import Alamofire

final class ViewController: UIViewController {

    @IBOutlet weak var valueTextField: UITextField!

    @IBOutlet weak var toButton: UIButton!
    @IBOutlet weak var forButton: UIButton!
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var valueLabel: UILabel!

    var sourceCurrency: String = "BRL" {
        didSet {
            toButton.setTitle("De: \(sourceCurrency)", for: [])
        }
    }

    var destinationCurrency: String = "USD" {
        didSet {
            forButton.setTitle("Para: \(destinationCurrency)", for: [])
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func fromButtonTapped() {
        let alertController = UIAlertController(title: "De", message: "Escolha a moeda base", preferredStyle: .actionSheet)

        alertController.addAction(UIAlertAction(title: "BRL", style: .default, handler: { (action) in
            self.sourceCurrency = action.title!
        }))

        alertController.addAction(UIAlertAction(title: "USD", style: .default, handler: { (action) in
            self.sourceCurrency = action.title!
        }))

        alertController.addAction(UIAlertAction(title: "Cancelar", style: .cancel))

        present(alertController, animated: true, completion: nil)
    }

    @IBAction func toButtonTapped() {
        let alertController = UIAlertController(title: "Para", message: "Escolha a moeda de destino", preferredStyle: .actionSheet)

        alertController.addAction(UIAlertAction(title: "USD", style: .default, handler: { action in
            self.destinationCurrency = action.title!
        }))

        alertController.addAction(UIAlertAction(title: "BRL", style: .default, handler: { action in
            self.destinationCurrency = action.title!
        }))

        alertController.addAction(UIAlertAction(title: "Cancelar", style: .cancel))

        present(alertController, animated: true, completion: nil)
    }

    @IBAction func convertButtonTapped() {
        let url = "https://api.exchangeratesapi.io/latest?symbols=\(sourceCurrency),\(destinationCurrency)&base=\(sourceCurrency)"

        AF.request(url).responseDecodable(of: ExchangeRatesResponse.self) { response in
            do {
                let exchangeRate = try response.result.get()
                let valueString = self.valueTextField.text!
                let valueDouble = Double(valueString) ?? 1
                let destinationValue = exchangeRate.rates[self.destinationCurrency] ?? 1
                let result = destinationValue * valueDouble

                self.valueLabel.text = "\(result)"
            } catch {
                self.show(error: error)
            }
        }
    }

    func show(error: Error) {
        let alertController = UIAlertController(title: "Erro na requisição", message: error.localizedDescription, preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: "Entendi", style: .cancel, handler: nil))

        present(alertController, animated: true, completion: nil)
    }
}

