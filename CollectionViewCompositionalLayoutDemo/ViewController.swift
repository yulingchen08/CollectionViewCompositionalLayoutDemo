//
//  ViewController.swift
//  CollectionViewCompositionalLayoutDemo
//
//  Created by 陳鈺翎 on 2022/8/14.
//

import UIKit

class ViewController: UIViewController {
    
    let  devices: [DeviceDTO] = [
        DeviceDTO(deviceID: 1, deviceName: "iPhone"),
        DeviceDTO(deviceID: 2, deviceName: "Macbook Pro"),
        DeviceDTO(deviceID: 3, deviceName: "Macbook Air"),
        DeviceDTO(deviceID: 4, deviceName: "iPad Pro"),
        DeviceDTO(deviceID: 5, deviceName: "Mac Mini"),
        DeviceDTO(deviceID: 6, deviceName: "iPad Air"),
        DeviceDTO(deviceID: 7, deviceName: "Apple Watch"),
        DeviceDTO(deviceID: 8, deviceName: "Magic Keyboard"),
        DeviceDTO(deviceID: 9, deviceName: "Magic Mouse"),
        DeviceDTO(deviceID: 10, deviceName: "Air Pods Pro"),
        DeviceDTO(deviceID: 11, deviceName: "Magic Mouse"),
        DeviceDTO(deviceID: 12, deviceName: "Magic Mouse"),
        DeviceDTO(deviceID: 13, deviceName: "Magic Mouse"),
        DeviceDTO(deviceID: 14, deviceName: "Magic Mouse"),
        DeviceDTO(deviceID: 15, deviceName: "Magic Mouse"),
        DeviceDTO(deviceID: 16, deviceName: "Magic Mouse"),
        DeviceDTO(deviceID: 17, deviceName: "Magic Mouse"),]
    
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    


}

//MARK: - Private
extension ViewController {
    private func setupUI() {
        let layout = UICollectionViewFlowLayout()  //***
        
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // section與section之間的距離(如果只有一個section，可以想像成frame)
        layout.itemSize = CGSize(width: (self.view.frame.size.width-30) / 3, height: 120) // cell的寬、高
        layout.minimumLineSpacing = CGFloat(integerLiteral: 10) // 滑動方向為「垂直」的話即「上下」的間距;滑動方向為「平行」則為「左右」的間距
        layout.minimumInteritemSpacing = CGFloat(integerLiteral: 2) // 滑動方向為「垂直」的話即「左右」的間距;滑動方向為「平行」則為「上下」的間距
        layout.scrollDirection = .vertical // 滑動方向預設為垂直。注意若設為垂直，則cell的加入方式為由左至右，滿了才會換行；若是水平則由上往下，滿了才會換列
        
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DeviceCeollectionVeiwCell.self, forCellWithReuseIdentifier: "cell") //***
        view.addSubview(collectionView)
    }
}




extension ViewController: UICollectionViewDelegate {
    //***
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Did select row: \(indexPath.row)")
    }
    
}


extension ViewController: UICollectionViewDataSource {
    //***
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return devices.count
    }
    //***
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //***
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DeviceCeollectionVeiwCell
        cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.orange : UIColor.brown
        cell.updateFrame(object: devices[indexPath.row])
        return cell
    }
    
    
}
