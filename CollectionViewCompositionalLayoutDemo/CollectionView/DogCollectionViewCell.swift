//
//  DogCollectionViewCell.swift
//  CollectionViewCompositionalLayoutDemo
//
//  Created by 陳鈺翎 on 2022/8/29.
//

import UIKit

class DogCollectionViewCell: UICollectionViewCell {
    
    var dogImageView: UIImageView = {
       let imageView = UIImageView(frame: CGRect(x: 5, y: 0, width: 40, height: 45))
        return imageView
    }()
    
    var nameLabel: UILabel = {
       let label = UILabel(frame: CGRect(x: 50, y: 0, width: 100, height: 45))
        label.textColor = .white
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 160, y: 0, width: 250, height: 45))
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        [dogImageView, nameLabel, descriptionLabel].forEach(addSubview)
    }
    
    func updateFrame(dog: Dog){
        dogImageView.image = UIImage(systemName: dog.imageName)
        nameLabel.text = dog.name
        descriptionLabel.text = dog.description
    }
    
    required init?(coder: NSCoder) {
        fatalError("Failed to init DogCollectionViewCell")
    }
}

