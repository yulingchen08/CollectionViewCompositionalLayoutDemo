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

    lazy var horizontalOneRowLayout: UICollectionViewLayout = {
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40))
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top, absoluteOffset: CGPoint(x: 0, y: 35))
        
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40))
        let footerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom, absoluteOffset: CGPoint(x: 0, y: 30))
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120))
       let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil, top: nil, trailing: .fixed(8), bottom: nil)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        section.boundarySupplementaryItems = [headerItem, footerItem]
    
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }()
    
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
        
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), collectionViewLayout: horizontalOneRowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DeviceCeollectionVeiwCell.self, forCellWithReuseIdentifier: "cell") //***
        
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "Footer")
        
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableView = UICollectionReusableView()
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        label.textAlignment = .left
        label.textColor = UIColor.white
        if kind == UICollectionView.elementKindSectionHeader {
            reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header", for: indexPath)
            reusableView.backgroundColor = .blue
            
            label.text = "Header"
            
        } else if kind == UICollectionView.elementKindSectionFooter {
            
            reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "Footer", for: indexPath)
            reusableView.backgroundColor = .orange
            label.text = "Footer"
        }
        
        reusableView.addSubview(label)
        return reusableView
    }
    
}
