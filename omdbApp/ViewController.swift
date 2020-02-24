//
//  ViewController.swift
//  omdbApp
//
//  Created by Alan Van Art on 2/20/20.
//  Copyright © 2020 Alan Van Art. All rights reserved.
//

import UIKit

class ViewController: UIViewController, OmdbDelegate {
    
    @IBOutlet weak var lblOutput: UILabel!
    @IBOutlet weak var txtInput: UITextField!
    
    let api_key = "fa4b0499"
    weak var omdb:OmdbDelegate?
    
    var posterURL: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // http://www.omdbapi.com/?i=tt3896198&apikey=fa4b0499
        
        
    }
    
    @IBAction func btnShowPoster(_ sender: Any) {
        omdb?.onShowPoster(poster: posterURL)
    }
    

    @IBAction func btnSearch(_ sender: Any) {
        
        var msgError: String = ""
        let apiUrl = "https://www.omdbapi.com/?t=" + txtInput.text!.replacingOccurrences(of: " ", with: "+") + "&apikey=" + api_key
        
        if let url = URL(string: apiUrl) {
        
            let task = URLSession.shared.dataTask(with: url) {
                (data, response, error) in
                
                if error != nil {
                    print(error!)
                } else {
                    if let urlContent = data {
                        do {
                        
                            let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                            if jsonResult["Error"] == nil {
                                    msgError = "no error"
                                }
                                
                            print(msgError)
                                
                            if (msgError == "no error"){
                                print(jsonResult["Year"]!!)
                                print(jsonResult["Rated"]!!)
                                print(jsonResult["Director"]!!)
                                print(jsonResult["Actors"]!!)
                                print(jsonResult["Poster"]!!)
                                self.posterURL = jsonResult["Poster"] as! String
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
    
    func onShowPoster(poster: String) {
        print(poster)
    }

}

