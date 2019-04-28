//
//  MainTableViewController.swift
//  Vologda
//
//  Created by Maxim Pyatovskiy on 25/04/2019.
//  Copyright © 2019 Maxim Pyatovskiy. All rights reserved.
//

import UIKit
import Alamofire

class MainTableViewController: UITableViewController {
    
    var areas = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Проверка на наличие интернета
    override func viewDidAppear(_ animated: Bool) {
        if (cultureArray.count == 0) {
            if Reachability.isConnectedToNetwork() == true {
                
                //Задаем параметры для get запроса
                let parameters = [
                    "id_dataset": "111504",
                ]
                
                //Запрос через Alamofire
                Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { response in
                    
                    data = response.result.value as! NSArray
                    UserDefaults.standard.set(data, forKey: "dataArray")
                    self.CultureFor()
                    cultureArray = culture
                    self.tableView.reloadData()
                    self.title = "Главная"
                }
                
            } else {
                if ((UserDefaults.standard.array(forKey: "dataArray")) == nil) {
                //Функция вызова alert, находится в conf/settings
                alerts(title: "Подключение к Интернету отсутствует", message: "Убедитесь, что ваше устройство подключено к Интернету", button_one: "Обновить", button_two: "Выйти",
                       
                       //Обновляем viewDidAppear
                    handler_one: {(alert: UIAlertAction!) in
                        self.viewDidAppear(true)},
                    
                    //Закрываем принудительно приложение
                    handler_two: {(alert: UIAlertAction!) in
                        exit(0)})
                } else {
                    data = UserDefaults.standard.array(forKey: "dataArray")! as NSArray
                    self.CultureFor()
                    cultureArray = culture
                    alerts(title: "Подключение к Интернету отсутствует", message: "Убедитесь, что ваше устройство подключено к Интернету", button_one: "Продолжить без интернета", button_two: "Обновить",
                           
                           //Обновляем viewDidAppear
                        handler_one: {(alert: UIAlertAction!) in
                            self.tableView.reloadData()
                            self.title = "Главная"},
                        
                        //Обновляем
                        handler_two: {(alert: UIAlertAction!) in
                             self.viewDidAppear(true)})
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cultureArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as! MainTableViewCell

        cell.Title.text = cultureArray[indexPath.row].name
        cell.Description.text = cultureArray[indexPath.row].adress
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let detailVC = segue.destination as! DetailViewController
                
                detailVC.id = indexPath.row
            }
        }
    }

    func CultureFor() {
        for i in 2 ..< data.count {
            let word = ((data[i] as! [String:Any])["Адрес объекта в соответствии  актом органа государственной власти о постановке под госохрану"] as? String)!
            if let index = word.range(of: ",")?.lowerBound {
                let substring = word[..<index]
                let string = String(substring)
                let trimmedString = string.trimmingCharacters(in: .whitespacesAndNewlines)
                if (!trimmedString.contains("г. Вологда")){
                    let up = Culture(name: ((data[i] as! [String:Any])["Наименование объекта"] as? String)!, area: trimmedString, adress: ((data[i] as! [String:Any])["Адрес объекта уточнённый"] as? String)!, type: ((data[i] as! [String:Any])["Вид объекта"] as? String)!, latitude: ((data[i] as! [String:Any])["Широта"] as? String)!, longitude: ((data[i] as! [String:Any])["Долгота"] as? String)!)
                culture.append(up)
                    if (!self.areas.contains(trimmedString)) {
                        self.areas.append(trimmedString)
                    }
                } else {
                    let up = Culture(name: ((data[i] as! [String:Any])["Наименование объекта"] as? String)!, area: "г. Вологда", adress: ((data[i] as! [String:Any])["Адрес объекта уточнённый"] as? String)!, type: ((data[i] as! [String:Any])["Вид объекта"] as? String)!, latitude: ((data[i] as! [String:Any])["Широта"] as? String)!, longitude: ((data[i] as! [String:Any])["Долгота"] as? String)! )
                    culture.append(up)
                    if (!self.areas.contains("г. Вологда")) {
                        self.areas.append("г. Вологда")
                    }
                }
            }
        }
    }
    @IBAction func refresh(_ sender: UIBarButtonItem) {
        cultureArray = []
        self.viewDidAppear(true)
    }
    
    @IBAction func areas(_ sender: UIBarButtonItem) {
        let ac = UIAlertController(title: nil, message: "Выберите район", preferredStyle: .alert)
        
        for i in 0 ..< areas.count {
            let callAction = UIAlertAction(title: areas[i], style: .default) {
                (action) in
                let areaString = self.areas[i]
                cultureArray = culture.filter { i in i.area == areaString }
                self.title = areaString
                self.tableView.reloadData()
            }
            ac.addAction(callAction)
        }
        
        let callActionAll = UIAlertAction(title: "Все районы", style: .default) {
            (action) in
            
            cultureArray = culture
            self.title = "Главная"
            self.tableView.reloadData()
            
        }
        
        let Cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        if cultureArray.count != culture.count {
            ac.addAction(callActionAll)
        }
        
        ac.addAction(Cancel)
        present(ac, animated: true, completion: nil)
    }
}

