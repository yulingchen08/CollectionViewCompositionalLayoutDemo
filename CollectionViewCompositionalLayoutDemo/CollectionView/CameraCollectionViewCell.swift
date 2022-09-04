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
    
    struct Object: Hashable {
        var id: String
        var title: String
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        idLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        idLabel.textColor = .black
        idLabel.textAlignment = .center
        
        nameLable = UILabel(frame: CGRect(x: 0, y: 41, width: 100, height: 40))
        nameLable.textColor = .blue
        nameLable.textAlignment = .center
        addSubview(idLabel)
        addSubview(nameLable)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateFrame(object: Object) {
        self.idLabel.text = object.id
        self.nameLable.text = object.title
        //self.nameLable.text = object.name
    }
}
