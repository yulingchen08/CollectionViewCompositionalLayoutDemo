//
//  DeviceCollectionViewCell.swift
//  CollectionViewCompositionalLayoutDemo
//
//  Created by 陳鈺翎 on 2022/8/14.
//

import UIKit

class DeviceCeollectionVeiwCell: UICollectionViewCell {
    var idLabel: UILabel!
    var nameLabel: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    
        
        idLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        idLabel.textColor = .black
        idLabel.textAlignment = .center
        self.addSubview(idLabel)
        
        
        nameLabel = UILabel(frame: CGRect(x: 0, y: 41, width: 100, height: 40))
        nameLabel.textColor = .darkGray
        nameLabel.textAlignment = .center
        self.addSubview(nameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateFrame(object: DeviceDTO) {
        idLabel.text = "\(object.deviceID)"
        nameLabel.text = object.deviceName
    }
}
