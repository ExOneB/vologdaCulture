//
//  settings.swift
//  Vologda
//
//  Created by Maxim Pyatovskiy on 25/04/2019.
//  Copyright © 2019 Maxim Pyatovskiy. All rights reserved.
//

import UIKit

var url : String = "http://www.opendata.gov35.ru/datasets/json.php"

var data: NSArray = []
var culture: [Culture] = []
var cultureArray: [Culture] = []

extension UIViewController {
    
    //Функция вызова Alert
    func alerts(title: String, message: String, button_one: String, button_two: String, handler_one: ((UIAlertAction) -> Void)? = nil, handler_two: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: button_one, style: .default, handler: handler_one))
        alert.addAction(UIAlertAction(title: button_two, style: .cancel, handler: handler_two))
        
        self.present(alert, animated: true)
    }
}
