//
//  CameraCollectionViewCell.swift
//  CollectionViewCompositionalLayoutDemo
//
//  Created by 陳鈺翎 on 2022/8/17.
//

import UIKit

class CameraCollectionViewCell: UICollectionViewCell {
    var idLabel: UILabel!
    var nameLable: UILabel!
    var imageView: UIImageView!
    
    struct Object: Hashable {
        var id: String
        var title: String
    }
    
    struct PhotoObject: Hashable {
        var id: Int
        var image: UIImage?
        var url: String
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        idLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        idLabel.textColor = .black
        idLabel.textAlignment = .center
        
        nameLable = UILabel(frame: CGRect(x: 0, y: 41, width: 100, height: 40))
        nameLable.textColor = .blue
        nameLable.textAlignment = .center
        
        imageView = UIImageView(frame:  CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.size.height))
        imageView.contentMode = .scaleAspectFit
        //addSubview(idLabel)
        //addSubview(nameLable)
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateFrame(object: Object) {
        self.idLabel.text = object.id
        self.nameLable.text = object.title
        //self.nameLable.text = object.name
    }
    
    func updatePhotoFrame(object: PhotoObject) {
        self.imageView.image = object.image
    }
}
