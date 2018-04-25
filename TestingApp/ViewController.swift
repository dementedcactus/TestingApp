//
//  ViewController.swift
//  TestingApp
//
//  Created by Richard Crichlow on 4/24/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let mainView = MainView()
    var movieData = [Movie]() {
        didSet {
            mainView.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(mainView)
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        mainView.tableView.rowHeight = UITableViewAutomaticDimension
        MovieAPI.manager.searchMovies(keyword: "Test") { (error, data) in
            if let error = error {
                print("Could not get data: \(error)")
            } else if let data = data {
                do {
                    let movieSearch = try JSONDecoder().decode(ResultsWrapper.self, from: data)
                    let movies = movieSearch.results
                    let unratedMovies = movies.filter({ (movies) -> Bool in
                        return movies.contentAdvisoryRating == "Unrated"
                    })
                    self.movieData = unratedMovies
                } catch {
                    print("Decoding error: \(error)")
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aMovie = movieData[indexPath.row]
        let cell = mainView.tableView.dequeueReusableCell(withIdentifier: "Movie Cell", for: indexPath) as! CustomTableViewCell
        
        cell.movieLabel.text = "\(aMovie.trackName)\n\(aMovie.longDescription ?? "")"
        cell.movieImageView.image = nil
        
        guard let imageUrlStr = aMovie.artworkUrl100 else {
            return cell
        }
        let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
            cell.movieImageView.image = onlineImage
            cell.setNeedsLayout()
        }
        
        ImageAPIClient.manager.getImage(from: imageUrlStr, completionHandler: completion, errorHandler: {print($0)})
        return cell
    }
    
}

