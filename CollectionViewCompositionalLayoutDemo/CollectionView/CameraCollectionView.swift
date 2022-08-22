//
//  CameraCollectionView.swift
//  CollectionViewCompositionalLayoutDemo
//
//  Created by 陳鈺翎 on 2022/8/17.
//

import UIKit

class CameraCollectionView: UIViewController {
    var collectionView: UICollectionView!
    let cameras: [CameraDTO] = [CameraDTO(id: 1, name: "Cannon"),
                                CameraDTO(id: 2, name: "Cannon"),
                                CameraDTO(id: 3, name: "Cannon"),
                                CameraDTO(id: 4, name: "Cannon"),
                                CameraDTO(id: 5, name: "Cannon"),
                                CameraDTO(id: 6, name: "Cannon"),
                                CameraDTO(id: 7, name: "Cannon"),
                                CameraDTO(id: 8, name: "Cannon"),
                                CameraDTO(id: 9, name: "Cannon"),
                                CameraDTO(id: 10, name: "Cannon"),
                                CameraDTO(id: 11, name: "Cannon"),
                                CameraDTO(id: 12, name: "Cannon"),
                                CameraDTO(id: 13, name: "Cannon"),
                                CameraDTO(id: 14, name: "Cannon"),
                                CameraDTO(id: 15, name: "Cannon"),
                    ]
    
    lazy var horizontalOneRowLayout: UICollectionViewLayout = {
        /// 4
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(120)
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.2),
            heightDimension: .absolute(120)
        )

        // 3 group 的功用，就是把一個或多個 item 圈在一起，利用這個特性，我們就可以做出許許多多的變化
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        //the amount of the sapce between the items in the group
        //item中間的空格大小
        //group.interItemSpacing = .fixed(8)
        group.edgeSpacing = NSCollectionLayoutEdgeSpacing(
            leading: nil,
            top: nil,
            trailing: .fixed(8),
            bottom: nil
        )

        /// 2
        let section = NSCollectionLayoutSection(group: group)
        //一旦被設定， CollectionView 的 section 實作會變成一個特別的橫向 scroll view
        //要讓這個 section 可以與 CollectionView 滾動的 90 度方向滾動
        section.orthogonalScrollingBehavior = .continuous
        //增加section的邊緣空間
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        /// 1
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }()
    
    lazy var multiItemSizeLayout: UICollectionViewLayout = {
        let smallItemSize = NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(45))
        let mediumItemSize = NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(65))
        let largeItemSize = NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(85))
        
        let smallItem = NSCollectionLayoutItem(layoutSize: smallItemSize)
        let mediumItem = NSCollectionLayoutItem(layoutSize: mediumItemSize)
        let largeItem = NSCollectionLayoutItem(layoutSize: largeItemSize)
        // 給剛好大小的 group
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(110), heightDimension: .absolute(205))
        // 用 .vertical 指明我們的 group 是垂直排列的
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [smallItem, mediumItem, largeItem])
        // 這裡指的是垂直的間距了，此為item和item之間的距離
        group.interItemSpacing = .fixed(5)
        //group和 group之間的距離
        group.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil, top: nil, trailing: .fixed(10), bottom: nil)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Doing setupUI")
        setupUI()
    }
}

//private
extension CameraCollectionView {
    private func setupUI() {
        let width = self.view.frame.width
        let height = self.view.frame.height
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: (width - 30) / 2  , height: 120)
        layout.minimumLineSpacing = CGFloat(integerLiteral: 10)
        layout.minimumInteritemSpacing = CGFloat(integerLiteral: 2)
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: width, height: height), collectionViewLayout: multiItemSizeLayout)
        collectionView.register(CameraCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        self.view.addSubview(collectionView)
        
    }
}


extension CameraCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Did select row: \(indexPath.row)")
    }
}


extension CameraCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cameras.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CameraCollectionViewCell
        cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.orange : UIColor.brown
        cell.updateFrame(object: cameras[indexPath.row])
        return cell
    }
}

