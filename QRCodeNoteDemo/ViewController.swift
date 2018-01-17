//
//  ViewController.swift
//  QRCodeNoteDemo
//
//  Created by langke on 2018/1/17.
//  Copyright © 2018年 langke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var qrCodeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func generateQRCode() {
        qrCodeImageView.generateQRCodeWith(url: urlTextField.text!)
    }
    
    @IBAction func GenerateQRCode2() {
        let url = "https://baike.baidu.com/item/二维码/2385673?fr=aladdin"
        qrCodeImageView.generateQRCodeWith(url: url)
    }
}

