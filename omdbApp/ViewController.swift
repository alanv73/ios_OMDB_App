//
//  ViewController.swift
//  omdbApp
//
//  Created by Alan Van Art on 2/20/20.
//  Copyright © 2020 Alan Van Art. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblOutput: UILabel!
    @IBOutlet weak var txtInput: UITextField!
    
    let api_key = "fa4b0499"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // http://www.omdbapi.com/?i=tt3896198&apikey=fa4b0499
        
        
    }

    @IBAction func btnSearch(_ sender: Any) {
        
        
        if let url = URL(string: "https://www.omdbapi.com/?t=" + txtInput.text!.replacingOccurrences(of: " ", with: "+") + "&apikey=" + api_key) {
        
            let task = URLSession.shared.dataTask(with: url) {
                (data, response, error) in
                
                if error != nil {
                    print(error!)
                } else {
                    if let urlContent = data {
                        do {
                        
                            let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                            if var msgError = jsonResult["Error"] {
                                if msgError == nil {
                                    msgError = "no error"
                                }
                                
                                print(msgError!)
                                
                                if (msgError as! String == "no error"){
                                    print(jsonResult["Year"]!!)
                                    print(jsonResult["Rated"]!!)
                                    print(jsonResult["Director"]!!)
                                    print(jsonResult["Actors"]!!)
                                    print(jsonResult["Poster"]!!)
                                }
                            }
                            
                            
                            
                            
                            
                        
                        } catch {
                            print(error)
                        }
                
                    }
                }
            }
            task.resume()
        }
    }
}

