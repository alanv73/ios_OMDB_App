//
//  PosterController.swift
//  omdbApp
//
//  Created by Alan Van Art on 2/24/20.
//  Copyright © 2020 Alan Van Art. All rights reserved.
//

import UIKit

class PosterController: UIViewController {
    
    
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var btnPoster: UIButton!
    
    public var posterURL: String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if posterURL != "" {
            getPoster(posterURL)
        } else {
            btnPoster.setTitle("No Poster Found", for: UIControl.State.normal)
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
    
    @IBAction func btnPosterDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getPoster (_ moviePoster: String) {
        print(moviePoster)
        
        let url = URL(string:moviePoster)

        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data, error == nil else { return }

            DispatchQueue.main.async() {    // execute on main thread
                let img = UIImage(data: data)
                self.movieImage.image = img //UIImage(data: data)
                self.movieImage.isHidden = false
//                self.btnPoster.setImage(img, for: UIControl.State.normal)
//                self.btnPoster.isHidden = false
            }
        }

        task.resume()
    }
    
    
}
