//
//  CustomTableViewCell.swift
//  TestingApp
//
//  Created by Richard Crichlow on 4/25/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    //userPhotoImageView
    lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = nil
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    // label
    lazy var movieLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Name"
        let font = UIFont(name: "Avenir-Heavy", size: 18)!
        lb.font = font
        return lb
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style , reuseIdentifier: "Movie Cell")
        setupAndConstrainObjects()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupAndConstrainObjects()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupAndConstrainObjects()
        
    }
    
    private func setupAndConstrainObjects(){
        addSubview(movieImageView)
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        movieImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        movieImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        movieImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
        movieImageView.heightAnchor.constraint(equalTo: movieImageView.widthAnchor).isActive = true
        movieImageView.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor).isActive = true
        movieImageView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor).isActive = true
        
        addSubview(movieLabel)
        movieLabel.translatesAutoresizingMaskIntoConstraints = false
        movieLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        movieLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 5).isActive = true
        movieLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
    }
}
