//
//  MovieTableViewCell.swift
//  CollectionViewCompositionalLayoutDemo
//
//  Created by 陳鈺翎 on 2022/8/28.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    var postImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var movieName: UILabel = {
       let label = UILabel(frame: CGRect(x: 100, y: 10, width: 150, height: 35))
        label.textColor = .blue
        return label
    }()
    
    var actorName: UILabel = {
       let label = UILabel(frame: CGRect(x: 250, y: 10, width: 100, height: 35))
        label.textColor = .black
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        [postImageView, movieName, actorName].forEach(addSubview)
        
    }
    
    func updateFrame(movie: Movie) {
        postImageView.image = UIImage(systemName: movie.imageName)
        movieName.text = movie.name
        actorName.text = movie.actor
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("UITableView cell init failed")
    }

    
}
