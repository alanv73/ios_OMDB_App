//
//  PosterController.swift
//  omdbApp
//
//  Created by Alan Van Art on 2/24/20.
//  Copyright © 2020 Alan Van Art. All rights reserved.
//

import UIKit

class PosterController: UIViewController {
    
    @IBOutlet weak var lblPoster: UILabel!
    public var posterURL: String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if posterURL != "" {
            lblPoster.text = posterURL
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
