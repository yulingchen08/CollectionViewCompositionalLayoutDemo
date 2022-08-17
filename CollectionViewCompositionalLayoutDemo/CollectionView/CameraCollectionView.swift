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
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: width, height: height), collectionViewLayout: layout)
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

