//
//  Movie.swift
//  TestingApp
//
//  Created by Richard Crichlow on 4/24/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import Foundation

struct ResultsWrapper: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let trackName: String
    let artistName: String
    let kind: String
    let artworkUrl100: String
    let contentAdvisoryRating: String
    let longDescription: String?
}


