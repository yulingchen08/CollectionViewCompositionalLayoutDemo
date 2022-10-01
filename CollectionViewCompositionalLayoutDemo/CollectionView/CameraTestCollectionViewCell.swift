//
//  CameraTestCollectionViewCell.swift
//  CollectionViewCompositionalLayoutDemo
//
//  Created by 陳鈺翎 on 2022/9/14.
//

import UIKit

class CameraTestCollectionViewCell: UICollectionViewCell {
    
    struct PhotoObject: Hashable {
        var id: Int
        var url: String
        var image: UIImage? = nil
    }
    
    lazy var cameraImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var idLabel: UILabel = {
       let label = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(cameraImageView)
        //addSubview(idLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Init CameraTestCollectionViewCell failed")
    }
    
    func updateFrame(object: PhotoObject) {
        self.cameraImageView.image = object.image
        self.idLabel.text = "abcde"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("layoutSubviews")
        idLabel.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        cameraImageView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
    }
    
}
