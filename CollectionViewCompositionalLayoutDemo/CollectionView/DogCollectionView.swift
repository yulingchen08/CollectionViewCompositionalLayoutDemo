//
//  DogCollectionView.swift
//  CollectionViewCompositionalLayoutDemo
//
//  Created by 陳鈺翎 on 2022/8/29.
//

import UIKit

enum DogType {
    case smallDog
    case MediumDog
    case LargeDog
}

struct Dog: Hashable {
    var id: String
    var name: String
    var description: String
    var imageName: String
}

class DogCollectionView: UIViewController {
        
    lazy var collectionView: UICollectionView = {
        
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
                let layout = UICollectionViewCompositionalLayout.list(using: config)
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: Screen.width), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(DogCollectionViewCell.self, forCellWithReuseIdentifier: "dogCell")
        return collectionView
    }()
    
    var smallDogs: [Dog] = [
        Dog(id: "1", name: "Pinky", description: "Cute dog", imageName: "ant"),
        Dog(id: "2", name: "Toro", description: "Smart dog", imageName: "ant")
    ]
    
    var mediumDogs: [Dog] = [
        Dog(id: "1", name: "Dumdum", description: "Stupid dog", imageName: "ant"),
        Dog(id: "2", name: "Mike", description: "Smart dog", imageName: "ant")
    ]
    
    var bigDogs: [Dog] = [
        Dog(id: "1", name: "Bruto", description: "Big dog", imageName: "ant"),
        Dog(id: "2", name: "Red", description: "Super Smart", imageName: "ant")
    ]
    
    
    var dataSource: UICollectionViewDiffableDataSource<DogType, Dog>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupDataSource()
        applySnapShot()
    }
    
}

extension DogCollectionView {
    private func setupCollectionView() {
        self.view.addSubview(collectionView)
    }
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<DogType, Dog>(collectionView: collectionView, cellProvider: { collectionView, indexPath, dog -> UICollectionViewCell in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dogCell", for: indexPath) as! DogCollectionViewCell
            cell.updateFrame(dog: dog)
            return cell
        })
        collectionView.dataSource = dataSource
    }
    
    private func applySnapShot() {
        var snapShot = NSDiffableDataSourceSnapshot<DogType, Dog>()
        snapShot.appendSections([.LargeDog, .MediumDog, .smallDog])
        snapShot.appendItems(bigDogs, toSection: .LargeDog)
        snapShot.appendItems(mediumDogs, toSection: .MediumDog)
        snapShot.appendItems(smallDogs, toSection: .smallDog)
        dataSource.apply(snapShot)
    }
    
}

extension DogCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
