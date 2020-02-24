//
//  DataDelegate.swift
//  omdbApp
//
//  Created by Alan Van Art on 2/23/20.
//  Copyright © 2020 Alan Van Art. All rights reserved.
//

import Foundation

protocol OmdbDelegate: class {
    func onShowPoster(poster: String)
}
