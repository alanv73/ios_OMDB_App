//
//  ViewController.swift
//  omdbApp
//
//  Created by Alan Van Art on 2/20/20.
//  Copyright © 2020 Alan Van Art. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var lblOutput: UILabel!
    @IBOutlet weak var txtInput: UITextField!
    @IBOutlet weak var btnPoster: UIButton!
    
    
    let api_key = "fa4b0499"
    var posterURL: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // http://www.omdbapi.com/?i=tt3896198&apikey=fa4b0499
        
        btnPoster.isHidden = true
        
    }
    
    @IBAction func btnShowPoster(_ sender: Any) {
        print(posterURL)
        
        performSegue(withIdentifier: "vcPoster", sender: sender)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "vcPoster" {
            if let posterViewController = segue.destination as? PosterController {
                posterViewController.posterURL = posterURL
            }
        }
    }
    
    @IBAction func btnClear(_ sender: Any) {
        txtInput.text = ""
        txtInput.becomeFirstResponder()
    }
    

    @IBAction func btnSearch(_ sender: Any) {
        
        var msgError: String = ""
        var msgOutput = ""
        
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
                        
                            if jsonResult["Error"] as? NSString == nil {
                                    msgError = "no error"
                                }
                                
                            print(msgError)
                                
                            if (msgError == "no error"){
                                msgOutput = "\(jsonResult["Title"] as! NSString) (\(jsonResult["Year"] as! NSString))\n"
                                msgOutput += "MPAA Rating: \(jsonResult["Rated"] as! NSString)\n"
                                msgOutput += "Directed by: \(jsonResult["Director"] as! NSString)\n"
                                var cast = "Cast: "
                                
                                let castArray = (jsonResult["Actors"] as! NSString).components(separatedBy: ", ")
                                for actor in castArray {
                                    cast += "\t" + actor + "\n\t\t"
                                }
                                
                                msgOutput += cast
                                
                                print(jsonResult)

                                self.posterURL = jsonResult["Poster"] as! String
                                
                                DispatchQueue.main.sync(execute: {
                                    self.btnPoster.isHidden = false
                                })
                                
                                
                            } else {
                                msgOutput = "Movie not found"
                                self.posterURL = ""
                                self.btnPoster.isHidden = true
                            }

                            DispatchQueue.main.sync(execute: {
                                self.lblOutput.frame = CGRect(x: 20, y: 245, width: 374, height: 408)
                                self.lblOutput.text = msgOutput
                                self.lblOutput.sizeToFit()
                            })
                            
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

